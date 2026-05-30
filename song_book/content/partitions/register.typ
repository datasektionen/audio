#import "/song_book/template.typ": (
  base-margin, page-number, partition-marker, virtual-page,
)

#show heading: set text(size: 30pt)
#partition-marker[Register]
#heading(level: 1)[Register]

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
}

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
