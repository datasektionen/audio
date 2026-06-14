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

/// Is a list of two integers:
/// 1. In how many pages the extra pages will be inserted (usually zero).
/// 2. How many extra pages will be added until the primary page counter
///    starts incrementing again. This is only decremented after the first
///    integer is zero.
#let extra-pages-count = state("extra-pages", (0, 0))
/// The visual page number, allowing extra pages to be inserted between primary
/// pages.
#let virtual-page = counter("virtual-page")

/// Inserts a number of extra pages after the current page. If this function was
/// called on page 'x' with 3, the extra pages will be numbered 'x.a'..'x.c'.
///
/// - number (int): The number of extra pages to insert.
/// - after (int): How many pages to wait until until the extra pages are
///   inserted. Is used for large content blocks which spans multiple pages,
///   which are hard to insert in the middle of.
/// -> content
#let insert-virtual-pages(number, after: 0) = {
  extra-pages-count.update(((after-count, count)) => (
    after-count + after,
    count + number,
  ))
}

/// Skipts the primary page counter a number of pages. Needs to be added after
/// the pagebreak that breaks to the first page that should have the skipped
/// page number.
#let skip-pages(number) = {
  virtual-page.update(count => count + number)
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

/// Formats page numbers as done in the book, with support for inserted pages.
///
/// - hex (bool): Whether to format the page numbers in hexadecimal. If
///   false, formats in decimal.
/// - numbers (array): The page number, should be a value of the `virtual-page`
///   counter. The first value is the primary page number, and the second value
///   (if present) is the secondary page number.
/// -> content
#let page-number(hex: false, ..numbers) = {
  let primary-page = numbers.pos().first()
  let secondary-page = numbers.pos().at(1, default: none)
  if hex {
    "0x" + upper(str(primary-page, base: 16))
  } else {
    left-pad-zeros(str(primary-page), 3)
  }
  if secondary-page != none {
    numbering(".a", secondary-page)
  }
}

#let song-book(body) = {
  set text(
    // This font was chosen since it was most similar free alternative to the
    // original PDF's font, "Bell MT", especially in its character height and
    // width.
    // It's installed by default in Typst btw!
    font: "Libertinus Serif",
    size: 11pt,
    lang: "sv",
    // This ensures that the text layouting box is the same height as with "Bell
    // MT", the font used in the original PDF.
    top-edge: 0.638em
  )
  set par(justify: false)
  show heading.where(level: 1): set text(size: 21pt, weight: "regular")
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
      context if 0 < extra-pages-count.get().at(1) and extra-pages-count.get().at(0) == 0 {
        virtual-page.step(level: 2)
      } else {
        virtual-page.step(level: 1)
      }
      extra-pages-count.update(((after-count, remaining-count)) => (
        calc.max(after-count - 1, 0),
        if after-count == 0 {
          calc.max(remaining-count - 1, 0)
        } else {
          remaining-count
        },
      ))

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
        let secondary-page = virtual-page.get().at(1, default: none)
        let show-decimal = is-left-page or secondary-page != none

        // Only show headers after the first partition has been defined.
        if (partition-number != none) {
          page-number(hex: not show-decimal, ..virtual-page.get())
        }
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
  
  show outline.entry: it => link(
    it.element.location(),
    [
      #it.body()
      #box(width: 1fr, it.fill)
      #page-number(..virtual-page.at(it.element.location()))
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
  notes-tracking: -0.23pt,
) = {
  set text(style: "italic", size: 10pt, tracking: notes-tracking)
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
/// - notes-tracking: Override for the font tracking in the notes text, i.e. the
///   extra space between characters.
/// - after-spacing: Override the space after the end of the song and the next
///   one.
/// - add-after-nth-par (none|array): If set, should be an array of arrays
///   containing an index and content. Each content will be inserted after the
///   paragraph with it's corresponding index (zero-indexed). Is used for
///   edge-cases where the layout needs adjustment in the middle of a song.
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
  notes-tracking: -0.23pt,
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
    body
    v(0em)
  }

  set par(leading: 4pt, spacing: 3.4mm)
  set heading(numbering: none)
  show heading: set text(size: 12pt)
  show heading: set block(below: 1.5mm)

  [
    #heading(level: 3, data.title) #id-label
    #metadata(data.title) <song-marker>
    #if "alttitle" in data and data.alttitle != none {
      let alt-titles = if type(data.alttitle) == array {
        data.alttitle
      } else {
        (data.alttitle,)
      }
      for alt-title in alt-titles [
        #metadata(alt-title) <song-marker>
      ]
    }

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
      set text(tracking: notes-tracking)
      song-notes(
        if override-notes-content == none {
          parse-text-content(data.notes)
        } else { override-notes-content },
        text-notes-spacing: text-notes-spacing,
        notes-leading: notes-leading,
        notes-spacing: notes-spacing,
        notes-tracking: notes-tracking,
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

/// Displays the "fortsätter på nästa sida..." text. This is separated since
/// for some songs it's more elegant to make this text align to the bottom of
/// the last paragraph.
#let continues-on-next-page-inline() = {
  text(size: 10pt)[_fortsätter på nästa sida..._]
}

/// Displays the "fortsätter på nästa sida..." text, aligned to the bottom right
/// of the page.
#let continues-on-next-page(dx: -4mm, dy: 4mm) = {
  
  place(bottom + right, dx: dx, dy: dy, continues-on-next-page-inline())
}
