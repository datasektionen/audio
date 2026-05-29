#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Roliga sånger][
  #show: block.with(width: 100%, breakable: false)
  #v(4.2mm)
  = #h(6pt) Roliga sånger
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 25pt,
    image(width: 88mm, "/song_book/assets/images/funny.png"),
  ))
]

#song(<nu_ska_jag_supa>)
#pagebreak()

#box[
  #song(<gass_te_dej>)
  #v(-4.6em)
  #pad(bottom: 15mm)[
    #align(center)[
      #image("/song_book/assets/images/Gäss _ter dej.png", width: 93mm)
    ]
  ]
]
#pagebreak()

#song(<yesterday>)
#pagebreak()

#song(<dance_macabre>)
#pagebreak()

#song(<berkeley_california>)
#pagebreak()

#song(<bruces_philosophers_song>)
#song(<fru_svenssons_lyckliga_karl>)
#pagebreak()

#song(<brev_fran_campus>)
#pagebreak()

#song(<en_matematiker>)
#pagebreak()

#song(<gaffas_visa>)
#pagebreak()

#song(<fyllevisa>)
#pagebreak()

#song(<lasa_matematik>)
#pagebreak()

#song(<kopparslagaren>)
#pagebreak()

#song(<nuskaviklamma>)
#song(<1_2_45>, text-first-line-indent: 0pt)
#pagebreak()

#song(<sangen_till_kvinnan>)
#pagebreak()

#song(<systeme_international>, text-first-line-indent: 0pt)
#song(<systeme_periodique>, text-first-line-indent: 0pt)
#pagebreak()
