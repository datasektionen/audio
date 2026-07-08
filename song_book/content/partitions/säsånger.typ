#import "/song_book/template.typ": (
  base-margin, continues-on-next-page-inline, partition-page, song, song-notes
)

#partition-page[Säsånger][
  #show heading: pad.with(left: 6pt)
  #show: block.with(width: 100%, breakable: false)
  #v(4.2mm)
  = Säsånger
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: -20pt,
    image(width: 88mm, "/song_book/assets/images/Cat-hokusai-2.png"),
  ))
]

#box(song(<langtan_till_landet>, text-spacing: 4mm, text-notes-spacing: 4mm))
#song(<nu_gronskar_det>)
#place(
  left + bottom,
  dx: -10mm,
  dy: 0mm,
  image(width: 65%, "/song_book/assets/images/Sid 153 left flowapowa.svg"),
)
#place(
  right + bottom,
  dx: -8mm,
  dy: -8mm,
  image(width: 50%, "/song_book/assets/images/Sid 153 right hairrypotta.svg"),
)
#pagebreak()

#box[
  #pad(right: -20mm)[#song(<idas_sommarvisa>, text-notes-spacing: 11pt)
  ]]
#pagebreak()

#song(<pippis_sommarvisa>)
#place(
  center + bottom,
  dx: 0mm,
  dy: 5mm,
  image(width: 90%, "/song_book/assets/images/Sid 155 pippi.svg"),
)
#pagebreak()

#song(
  <den_blomstertid_nu_kommer>,
  add-after-nth-par: ((2, align(right, continues-on-next-page-inline())),),
)
#song(<varvindar_friska>)
#pagebreak()

#song(<kraftan_ar_ett_lackert_djur>)
#place(
  center + bottom,
  dx: -10mm,
  dy: 5mm,
  image(width: 90%, "/song_book/assets/images/Sid 158 kraftan.svg"),
)
#pagebreak()

#song(<kraftor_atas>)
#place(
  center + bottom,
  dx: -10mm,
  dy: 10mm,
  image(width: 105%, "/song_book/assets/images/Sid 159 hulukrafta.svg"),
)
#pagebreak()

#song(<tusen_ljus>)
#pagebreak()

#song(<betlehems_stjarna>)
#pagebreak()

#song(
  <lucia_ver1>,
  add-after-nth-par: ((4, align(right, continues-on-next-page-inline())),),
)
#song(<nu_ar_det_jul_igen>)
#place(
  center + bottom,
  dx: 0mm,
  dy: 0mm,
  image(width: 45%, "/song_book/assets/images/Sid 163 djuldanke.svg"),
)
#pagebreak()

#block(breakable: false, song(
  <nu_har_vi_ljus>,
  text-spacing: 3.4mm,
  text-notes-spacing: 3.4mm,
))
#song(<hej_tomtegubbar>)
#pagebreak()
