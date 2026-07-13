#import "/song_book/template.typ": (
  base-margin, insert-virtual-pages, partition-page, skip-pages, song,
  song-notes
)

#partition-page[Högtid][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Högtid
  #v(-4.2mm)
  #align(center, pad(
    left: -base-margin - 5mm,
    top: 2pt,
    image(width: 130mm, "/song_book/assets/images/Sid 145 cattime.svg"),
  ))
]

#song(<studentsangen>)
#pagebreak()

#song(<sang_till_norden>)
#pagebreak()

#song(<o_gamla_klang>)
#pagebreak()

#box(song(<kungssangen>, text-notes-spacing: 9pt))
#pagebreak()
