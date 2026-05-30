#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

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

#song(<imperial_punsch>)
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
