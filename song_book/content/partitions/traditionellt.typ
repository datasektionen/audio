#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Traditionellt][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Traditionellt
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 15pt,
    image(width: 100mm, "/song_book/assets/images/traditionellt.png"),
  ))
]

#song(<fredmans_sang_no_21>)
#pagebreak()

#pad(bottom: 5%)[#song(<stockholm_i_mitt_hjarta>)]
#pagebreak()

#song(<lyft_ditt_valforsedda_glas>)
#pagebreak()

#song(<an_en_gang_daran>)
#pagebreak()

#song(<frans_michael_franzens_dryckesvisa>)
#pagebreak()

#song(<jag_fangade_en_rav>)
#pagebreak()

#song(<om_haga>)
#pagebreak()

#song(<uti_var_hage>)
#pagebreak()
