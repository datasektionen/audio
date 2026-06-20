#import "/song_book/template.typ": base-margin, partition-page, song, song-notes, skip-pages, insert-virtual-pages

#partition-page[Roliga sånger][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Roliga sånger
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 25pt,
    image(width: 88mm, "/song_book/assets/images/funny.png"),
  ))
]

#song(<gravolsvisa_fran_rengsjo>)
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

#skip-pages(3)

#song(<bruces_philosophers_song>)
#song(<fru_svenssons_lyckliga_karl>)
#pagebreak()

#song(<brev_fran_campus>)
#pagebreak()

#song(<en_matematiker>, override-notes-content: [
  #set par(leading: 4pt)
  ρ (rho) syftar på den grekiska bokstaven, vilket ibland benämns som "the plastic number" vilket är den unika reella lösningen på ekvationen $x^3 = x + 1$.\
  ρ kallas ibland även "the silver number", vilket används för "the silver ratio": $1 + sqrt(2)$.
])
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
#song(<siffervisan>, text-first-line-indent: 0pt)
#pagebreak()

#song(<sangen_till_kvinnan>)
#pagebreak()

#song(<systeme_international>, text-first-line-indent: 0pt)
#song(<systeme_periodique>, text-first-line-indent: 0pt)
#pagebreak()

#insert-virtual-pages(2)
#song(<portho_s_song>)
#pagebreak()

#song(<hallen_lutar>)
#pagebreak()
