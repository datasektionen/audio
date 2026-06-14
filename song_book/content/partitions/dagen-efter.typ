#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Dagen efter][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Dagen efter
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 15pt,
    image(width: 88mm, "/song_book/assets/images/dagen_efter.png"),
  ))
]

#box[
  #song(<treo>)
  #song(<vit_vecka>)
]
#pagebreak()

#song(<anti-snapsvisa>)
#song(<invers_aptit>)
#pagebreak()

#song(<ont_i_huvet>)
#pagebreak()

#song(<ronnerdahl>)
#pagebreak()
