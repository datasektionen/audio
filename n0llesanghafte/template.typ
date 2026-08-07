#import "text-content.typ" : (parse-text-content, split-at-blocks)

#let base-margin-top = 25mm
#let base-margin-bottom = 27mm
#let base-margin-x = 27.7mm

#let page-width = 6.8in
#let page-height = 9.24in

#let songs-data = json("songs.json")

#let skipped-pages = state("skipped-pages", ())

#let sv-sort-key(s) = {
  let key = lower(s)
  key = key.replace("å", "{1")
  key = key.replace("ä", "{2")
  key = key.replace("ö", "{3")
  key
}

#let titel-meta = json("data/titel images/titel.json")
#let meta-data = json("data/meta.json")

#let load-personalen-data() = {
  let hidden-branches = meta-data.hidden_branch_names
  let raw = json("data/personalen.json")
  let dict = (:)
  for value in raw {
    if hidden-branches.contains(value.branch_name) {
      continue
    }
    let branch-data = dict.at(value.branch_name, default: ())
    branch-data.push((value))
    dict.insert(value.branch_name, branch-data)
  }

  for key in dict.keys() {
    dict.insert(key, dict.at(key).sorted(key: person => sv-sort-key(person.name)))
  }



  return dict
}

#let personalen-data = load-personalen-data()

#let find-person(kth-id) = {
  for (branch, personal) in personalen-data {
    for person in personal {
      if person.kth_username == kth-id {
        return person
      }
    }
  }
  panic("Did not find person with kth-id: " + kth-id)
}

/// Removes page numbering from specified amount of pages, from this page.
/// - pages-skipped (int): 
/// -> none
#let remove-page-numbering(pages-skipped) = {
   context {
    let page-number = counter(page).get().at(0) - 1
    for value in range(0, pages-skipped) {
      skipped-pages.update(arr => {
        arr.push(page-number + value)
        arr
      })
    }
  }
}

#let song-book(body) = {
  let header-line-thickness = 0.3pt

  set page(
    width: page-width,
    height: page-height,
    margin: (
      x: base-margin-x,
      top: base-margin-top,
      bottom: base-margin-bottom,
    ),
    background: image("resources/background.pdf"),/*place[#pad(x: base-margin,
    y: base-margin)[#rect(width: 100%, height: 100%, stroke: 0.5pt)]]*/
    footer: context [
      #v(-20mm)
      #let page-number = counter(page).get().at(0) - 1
      #if skipped-pages.get().contains(page-number) {} else {
        align(center)[#text(size: 27pt)[#page-number]]
      }
    ]
  )

  body
}

/// 
///
/// - id-label (label): A label containing one of the top level IDS in "songs.json".
/// - title-size: Override for the font size of the title.
/// - text-size: Override for the font size of the song text.
/// - meta-text-size: Override for the font size of the meta-text. 
/// - text-spacing: Override for the paragraph spacing in the main song text.
/// - text-leading: Override for the spacing between lines in the main song text.
/// - override-text-content (none|content): If set, replaces the text content.
/// -> content
#let song(
  id-label,
  title-size: 14pt,
  text-size: 10pt,
  notes-text-size: 9pt,
  notes-width: 70mm,
  meta-text-size: 9pt,
  text-spacing: 1.2em,
  text-leading: 0.65em,
  text-notes-spacing: 0mm,
  override-text-content: none,
  override-meta-text-content: none,
  override-title-content: none,
  override-notes-content: none,
  text-columns: 1,
  paragraphs-per-column: (),
  column-gutter: 1.5em,
) = {
  assert(
    str(id-label) in songs-data,
    message: "\"" + str(id-label) + "\" isn't in songs.json",
  )
  let data = songs-data.at(str(id-label))
  
  let text-to-columns(text) = {
    if text-columns <= 1 {
      text
    } else {
      let paragraphs = split-at-blocks(text)
      let total = paragraphs.len()

      assert(
        paragraphs-per-column.len() == text-columns,
        message: "paragraphs-per-column must have exactly "
          + str(text-columns) + " entries (one per column), got "
          + str(paragraphs-per-column.len()),
      )
      assert(
        paragraphs-per-column.sum() == total,
        message: "paragraphs-per-column entries sum to "
          + str(paragraphs-per-column.sum()) + " but the text has "
          + str(total) + " paragraphs",
      )

      let cols = ()
      let cursor = 0
      for count in paragraphs-per-column {
        let chunk = paragraphs.slice(cursor, cursor + count)
        cols.push(chunk.join())
        cursor += count
      }

      grid(
        columns: range(text-columns).map(_ => 1fr),
        column-gutter: column-gutter,
        ..cols
      )
    }
  }

  let song-text(body) = {
    set text(size: text-size)
    set par(spacing: text-spacing, leading: text-leading)
    text-to-columns(body)
    v(0em)
  }

  let notes-text(body) = {
    if body == none or body == "" {
      return
    }
    set text(size: notes-text-size, style: "italic")
    v(text-notes-spacing)
    align(center)[]
    box(parse-text-content(body), width: notes-width)
  }

  box[
    #text(size: title-size)[#heading(level: 3, if override-title-content == none {data.title} else {override-title-content})]
    #v(-0.5em)
    #text(size: meta-text-size, style: "italic")[
      #if override-meta-text-content == none {
        parse-text-content(data.meta)
      } else {
        override-meta-text-content
      }
    ]
    #song-text(if override-text-content == none {
      parse-text-content(data.text)
      } else {
        override-text-content
      }
    )
    #notes-text(if override-notes-content == none {
        data.notes
      } else {
        override-notes-content
      }
    )
  ]
}

#let get-current-page-number() = context {
  return counter(page).get().at(0)
}