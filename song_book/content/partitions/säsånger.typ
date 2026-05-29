#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Säsånger][
  #show: block.with(width: 100%, breakable: false)
  #v(4.2mm)
  = #h(6pt) Säsånger
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: -20pt,
    image(width: 88mm, "/song_book/assets/images/Cat-hokusai-2.png"),
  ))
]

#song(<langtan_till_landet>)
#song(<nu_gronskar_det>)
#pagebreak()

#box[
  #pad(right: -20mm)[#song(<idas_sommarvisa>, text-notes-spacing: 11pt)
  ]]
#pagebreak()

#song(<pippis_sommarvisa>)
#pagebreak()

#song(<den_blomstertid_nu_kommer>)
#song(<varvindar_friska>)
#pagebreak()

#song(<kraftan_ar_ett_lackert_djur>)
#pagebreak()

#song(<kraftor_atas>)
#pagebreak()

#song(<tusen_ljus>)
#pagebreak()

#song(<betlehems_stjarna>)
#pagebreak()

#song(<lucia_ver1>)
#song(<nu_ar_det_jul_igen>)
#pagebreak()

#song(<nu_har_vi_ljus>)
#song(<hej_tomtegubbar>)
#pagebreak()
