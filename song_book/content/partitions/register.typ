#import "/song_book/template.typ": (
  base-margin, insert-virtual-pages, page-number, partition-marker, virtual-page,
)

#show heading: set text(size: 30pt)
#partition-marker[Register]
#heading(level: 1)[Register]

// Titles and alternate titles which won't be shown in the register.
#let title-block-list = (
  "Trippeln",
  "Ett noll ett",
  "Nu ska vi ha ljus",
  "Om cykling med mera",
)

// Returns pairs of all song titles and their corresponding page numbers and
// locations, sorted by title.
#let entries() = {
  query(<song-marker>)
    .map(metadata => {
      (
        metadata.value,
        page-number(..virtual-page.at(metadata.location())),
        metadata.location(),
      )
    })
    .sorted(key: ((title, page, _)) => (title, page))
    .filter(((title, _, _)) => str(title) not in title-block-list)
}

#insert-virtual-pages(1, after: 5)

#context {
  set text(size: 10pt)
  set par(leading: 2.6pt)
  for (title, page, location) in entries() {
    link(location)[
      #title#"  "#page
    ]
    linebreak()
  }
}

#pagebreak()
