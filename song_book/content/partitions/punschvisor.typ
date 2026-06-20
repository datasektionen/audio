#import "/song_book/template.typ": base-margin, partition-page, song, song-notes, insert-virtual-pages

#partition-page[Punschvisor][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Punschvisor
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 15pt,
    image(width: 88mm, "/song_book/assets/images/tillpunschen.png"),
  ))
]

#song(<punschen_kommer_kall>)
#song(<punschen_kommer_varm>)
#pagebreak()

#song(<punschens_lov>)
#pagebreak()

#song(<djungelpunsch>)
#pagebreak()

#song(<anglapunsch>)
#pagebreak()

#box[
  #song(<imperial_punsch>, text-notes-spacing: 1em)
  #v(-1.5em)
  #song(<var_ar_punschen>)
]
#pagebreak()

#song(<studiemedelsrondo>)
#song(<nar_kaffet_ar_serverat>)
#pagebreak()

#song(<hederlige_stures_visa>)
#song(<tentaforberedelser>)
#pagebreak()

#song(<punschlatt>)
#song(<sista_punschvisan>)
#pagebreak()

#insert-virtual-pages(2)
#song(<metaspexets_punschvisa>)
#song(<sveriges_arraktionalhymn>)