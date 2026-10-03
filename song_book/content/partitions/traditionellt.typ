#import "/song_book/template.typ": (
  base-margin, continues-on-next-page-inline, partition-page, song, song-notes,
  insert-virtual-pages
)

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
#place(
  center + bottom,
  dx: 0mm,
  dy: -10mm,
  image(width: 100%, "/song_book/assets/images/Sid 135 kth.svg"),
)
#pagebreak()

#song(<lyft_ditt_valforsedda_glas>)
#place(
  center + bottom,
  dx: 0mm,
  dy: 5mm,
  image(width: 75%, "/song_book/assets/images/Sid 136 shotOclock.svg"),
)
#pagebreak()

#song(<an_en_gang_daran>)
#pagebreak()

#song(<frans_michael_franzens_dryckesvisa>)
#pagebreak()

#place(
      left + horizon,
      dy: 13mm,
      dx: 30mm,
      image(width: 86%, "/song_book/assets/images/Dog Poker table shadow-transparent.png"),
    )
#song(<jag_fangade_en_rav>)
#pagebreak()

#insert-virtual-pages(4)

#song(<bort_allt_vad_oro_gor>)
#pagebreak()

#song(<i_kalifornien>, text-notes-spacing: 3.4mm)
#pagebreak()

#song(
  <gaudeamus_igitur>,
)
#pagebreak()

#song(<om_haga>)
#place(
  center + bottom,
  dx: -10mm,
  dy: 7mm,
  image(width: 100%, "/song_book/assets/images/Sid 143 smoerflygare.svg"),
)
#pagebreak()

#song(<uti_var_hage>)
#pagebreak()
