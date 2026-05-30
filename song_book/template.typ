#import "text-content.typ": parse-text-content

#let songs-data = json("../songs.json")

/// The default amount of padding, used (among others) for song pages.
#let base-margin = 12.7mm

#let left-pad-zeros(str, min-len) = {
  ("0" * calc.max(min-len - str.len(), 0)) + str
}

/// Displays the message binary string for the current page. Each page gets two of the Unicode codepoints in "DATASEKTIONENS SÅNGBOK", encoded in binary.
#let page-message-codepoints-binary = context {
  let message = "DATASEKTIONENS SÅNGBOK"

  let page-number = counter(page).get().at(0) - 1

  // Gets the codepoint at the specified index, mod the number of codepoints in `str`, and encodes it in binary, padded to a length of 8.
  let get-codepoint-wrapped-binary(string, codepoint-index) = {
    let index = calc.rem(codepoint-index, string.codepoints().len())
    left-pad-zeros(
      str(string.codepoints().at(index).to-unicode(), base: 2),
      8,
    )
  }

  [
    #get-codepoint-wrapped-binary(message, page-number * 2)
    #get-codepoint-wrapped-binary(message, page-number * 2 + 1)
  ]
}

/// How many extra pages will be added until the primary page counter starts
/// incrementing again.
#let remaining-extra-pages = state("extra-pages", 0)
/// The visual page number, allowing extra pages to be inserted between primary
/// pages.
#let virtual-page = counter("virtual-page")

/// Inserts a number of extra pages after the current page. If this function was
/// called on page 'x' with 3, the extra pages will be numbered 'x.a'..'x.c'.
///
/// - number (int): The number of extra pages to insert.
/// -> content
#let insert-virtual-pages(number) = {
  remaining-extra-pages.update(count => count + number)
}

/// Defines a new partition without any visual content.
/// `body` should contain the name of the partition.
#let partition-marker(body) = [#metadata(body) <partition-marker>]

/// Defines a new partition and creates a new page only containing `body` heading element along with metadata which defines a new partition.
#let partition-page(partition-content, body) = {
  pagebreak(weak: true)
  partition-marker(partition-content)

  show heading: set text(size: 30pt, weight: "regular")
  body
  pagebreak()
}

/// Evaluates to the location of the next page element
#let next-page() = query(selector(<page-end>).after(here())).first().location()

#let current-partition-number() = {
  let count = counter(<partition-marker>).at(next-page()).first()
  if count <= 0 {
    none
  } else {
    count - 1
  }
}

#let current-partition-text() = {
  let partitions = query(selector(<partition-marker>).before(next-page()))

  if partitions.len() == 0 {
    return none
  } else {
    partitions.last().value
  }
}

#let song-book(body) = {
  // You need to have this font installed, sorry!
  set text(font: "Bell MT", size: 11pt, lang: "sv")
  set par(justify: false)
  show heading.where(level: 1): set text(size: 22pt, weight: "regular")
  show heading.where(level: 1): set block(below: 10pt)

  // Configure the A6 page layout
  set page(
    paper: "a6",
    margin: (
      top: base-margin,
      bottom: base-margin,
      left: base-margin,
      right: base-margin,
    ),
    header: {
      // Increment virtual page
      context if 0 < remaining-extra-pages.get() {
        virtual-page.step(level: 2)
      } else {
        virtual-page.step(level: 1)
      }
      remaining-extra-pages.update(count => calc.max(count - 1, 0))

      context {
        let page = counter(page).get().at(0)
        let is-left-page = calc.rem(page, 2) == 0

        show: align.with(if is-left-page { left } else { right } + bottom)
        set par(leading: 5pt)

        let partition-number = current-partition-number()

        // Only show headers after the first partition has been defined.
        if partition-number != none [
          #text(size: 10.5pt, {
            if is-left-page {
              [Konglig Datasektionens Sångbok]
            } else {
              [Partition #partition-number -- #current-partition-text()]
            }
          })\
          #text(size: 5.3pt, page-message-codepoints-binary)
          #v(-2pt)
        ]
      }
    },
    footer: (
      context {
        let is-left-page = calc.rem(counter(page).get().first(), 2) == 0

        // TODO: Figure out precise text size
        set text(size: 12pt)

        show: align.with(if is-left-page { left } else { right } + bottom)

        show: pad.with(left: -base-margin, right: -base-margin)
        show: pad.with(x: 7mm, y: 6mm)

        let partition-number = current-partition-number()

        let primary-page = virtual-page.get().first()
        // let primary-page = counter(page).get().first()
        let secondary-page = virtual-page.get().at(1, default: none)
        let show-decimal = is-left-page or secondary-page != none
        // let show-decimal = is-left-page

        // Only show headers after the first partition has been defined.
        if (partition-number != none) {
          if show-decimal {
            left-pad-zeros(str(primary-page), 3)
          } else {
            "0x" + upper(str(primary-page, base: 16))
          }
        }
        virtual-page.display((primary-page, ..remaining) => {
          let secondary-page = remaining.pos().first(default: none)
          if secondary-page == none {
            return
          }
          "." + str.from-unicode("a".to-unicode() - 1 + secondary-page)
        })
      }
    )
      // Add marker for end of page to be queried for.
      + [#metadata(none) <page-end>],
  )

  // Title Page
  align(center + top)[
    #set page(margin: (x: 0pt, y: base-margin))
    #set par(spacing: 0pt)
    #show title: set text(size: 16pt, weight: "bold")
    #title[Konglig Datasektionens Sångbok]
    #v(1.5mm)
    #image(height: 62.5mm, "assets/images/delta-logo.svg")
    #v(4.5mm)
    #text(size: 23pt)[/dev/audio]
  ]
  pagebreak()
  // Add blank page after title.
  pagebreak()

  body
}

#let table-of-contents() = {
  show heading: set text(size: 30pt)
  show heading: set block(below: 12pt)
  show outline.entry: set text(size: 12pt)
  
  let page-number(location) = numbering("1", ..virtual-page.at(location))
  show outline.entry: it => link(
    it.element.location(),
    [
      #it.body()
      #box(width: 1fr, it.fill)
      #page-number(it.element.location())
    ]
  ) + linebreak()

  outline(target: heading.where(level: 1))
  pagebreak()
}

/// Formats content as the italic notes at the end of a song.
///
/// - body (content):
/// ->
#let song-notes(
  body,
  text-notes-spacing: 3.4mm,
  notes-leading: 3.7pt,
  notes-spacing: 3.4mm,
) = {
  set text(style: "italic", size: 10pt)
  set par(leading: notes-leading, spacing: notes-spacing)
  v(text-notes-spacing, weak: true)
  body
}

/// Renders a song.
///
/// - id-label (label): A label containing one of the top level IDs in
///   "songs.json".
/// - text-size: Override for the font size of the main song text.
/// - text-leading: Override for the spacing between lines in the main song
///   text.
/// - text-spacing: Override for the paragraph spacing in the main song text.
/// - meta-text-spacing: Override for the space between the meta and main song
///   texts.
/// - text-notes-spacing: Override for the space between the main song and
///   notes texts.
/// - notes-leading: Override for the spacing between lines in the notes text.
/// - notes-spacing: Override for the paragraph spacing in the notes text.
/// - after-spacing: Override the space after the end of the song and the next
///   one.
/// - add-after-nth-par (none|tuple): If set, should be an array containing an
///   index and content. That content will be inserted after the paragraph with
///   that index (zero-indexed). Is used for edge-cases where the original PDF
///   has manually adjusted the layout in the middle of a song.
/// - override-text-content (none|content): If set, replaces the text content
///   with the provided content, instead of reading it from "songs.json".
/// - override-notes-content (none|content): If set, replaces the notes content
///   with the provided content, instead of reading it from "songs.json".
/// - text-first-line-indent: Override for the indentation of the first line in
///   each paragraph of the main song text.
#let song(
  id-label,
  text-size: 11pt,
  text-leading: 4pt,
  text-spacing: 0.2in,
  meta-text-spacing: 3.4mm,
  text-notes-spacing: 0.2in,
  notes-leading: 3.7pt,
  notes-spacing: 3.4mm,
  after-spacing: 9mm,
  add-after-nth-par: none,
  override-text-content: none,
  override-notes-content: none,
  text-first-line-indent: 6pt,
) = {
  assert(
    str(id-label) in songs-data,
    message: "\"" + str(id-label) + "\" isn't in songs.json",
  )

  let data = songs-data.at(str(id-label))

  let song-meta(body) = {
    set text(style: "italic", size: 10pt)
    body
    v(0em)
  }

  let song-text(body) = {
    set text(size: text-size)
    set par(spacing: text-spacing, leading: text-leading)
    // TODO: Temporary to check consistency with original, remove once all songs
    //   have been added.
    set par(first-line-indent: (amount: text-first-line-indent, all: true))
    body
    v(0em)
  }

  set par(leading: 4pt, spacing: 3.4mm)
  set heading(numbering: none)
  show heading: set text(size: 12pt)
  show heading: set block(below: 1.5mm)

  [
    #heading(level: 3, data.title) #id-label

    #song-meta(parse-text-content(data.meta))

    #v(meta-text-spacing, weak: true)
    #song-text(if override-text-content == none {
      parse-text-content(
        data.text,
        add-after-nth-par: add-after-nth-par,
      )
    } else {
      override-text-content
    })

    #if data.notes != none {
      song-notes(
        if override-notes-content == none {
          parse-text-content(data.notes)
        } else { override-notes-content },
        text-notes-spacing: text-notes-spacing,
        notes-leading: notes-leading,
        notes-spacing: notes-spacing,
      )
    } else { none }
  ]
  v(after-spacing, weak: true) // Space after the song
}

/// Displays the description text of a footnote.
#let footnote-entry(body) = {
  set text(size: 10pt, style: "italic")
  body
}
