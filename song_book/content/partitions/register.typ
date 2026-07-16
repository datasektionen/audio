#import "/song_book/template.typ": (
  base-margin, insert-virtual-pages, page-number, partition-marker, virtual-page,
)

#show heading: set text(size: 30pt)
#partition-marker[Register]
#heading(level: 1)[Register]

// Titles and alternate titles which won't be shown in the register.
#let title-block-list = (
  "Ett noll ett",
  "Nu ska vi ha ljus",
  "Om cykling med mera",
)

// Returns pairs of all song titles and their corresponding page numbers and
// locations, sorted by title.
#let entries() = {
  let observed-titles = ();
  let found-songs = query(<song-marker>)
    .map(metadata => {
      (
        metadata.value,
        page-number(..virtual-page.at(metadata.location())),
        metadata.location(),
      )
    })
    // Filter out blocked and duplicate titles. This is necessary since
    // "Trippeln" is an alternative title to three songs, but we only want one
    // of them in the registry.
    .fold(((), ()), ((found-songs, observed-titles), song-data) => {
      let (title, _, _) = song-data
      (
        found-songs + if str(title) not in title-block-list and str(title) not in observed-titles {
          (song-data,)
        } else {
          ()
        },
        observed-titles + (str(title),),
      )
    })
    .first()
  // found-songs += (([Trippeln], 14, none),)
  found-songs.sorted(key: ((title, page, _)) => (title, page))
}

#insert-virtual-pages(2, after: 6)

#context {
  // Ensure that registry entries don't wrap to multiple lines.
  show: pad.with(right: -base-margin)

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
