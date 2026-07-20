#import "/song_book/template.typ": (
  base-margin, continues-on-next-page, partition-page, song, song-notes,
  insert-virtual-pages, skip-pages
)

#partition-page[Nubbevisor][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Nubbevisor
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 45pt,
    image(width: 100mm, "/song_book/assets/images/nubbevisor.png"),
  ))
]

#let subheader-size = 24pt

#box[
   #text(size: subheader-size)[Helan]
  #song(<helan_gar>, after-spacing: 6mm)
  #song(<hell_and_gore>)
]
#pagebreak()

#box[
  #song(<denna_thaft>)
   #text(size: subheader-size)[Halvan]
  #song(<tank_om_jag_hade>)
]
#pagebreak()

#song(<ode_till_halvan>)
#song(<ratt_lyft>)
#song(<helangorakatt>)
#pagebreak()

 #text(size: subheader-size)[Tersen]
#song(<can_can>)
#place(
  right + bottom,
  dx: 10mm,
  dy: 10mm,
  image(width: 100%, "/song_book/assets/images/Sid 110 grajsenbajken.svg"),
)
#pagebreak()

#song(<om_cykling>, text-spacing: 13pt)
#song(<mera_jarn>)
#pagebreak()

#song(<imbelupet>)
#pagebreak()

 #text(size: subheader-size)[Qvarten]
#song(<grav_ur_tundran>)
#place(
  center + bottom,
  dx: 0mm,
  dy: 7mm,
  image(width: 75%, "/song_book/assets/images/Sid 113 potatos.svg"),
)
#pagebreak()

#song(<detta_glas>)
#song(<en_gang_i_manan>)
#pagebreak()

 #text(size: subheader-size)[Qvinten]

#song(<regalskeppet_vasa>)
#song(<magen_brummar>)
#pagebreak()

#box[
  #song(<lilla_manasse>)
  #song(<kors>, text-notes-spacing: 3.5mm)
]
#pagebreak()

 #text(size: subheader-size)[Sexten]
#song(<vodka_vodka>)
#song(<angbaten>)
#pagebreak()

 #text(size: subheader-size)[Måsen]
#song(<masen>)
#song(<datalogen>)
#pagebreak()

#song(<jasen>)
#song(<the_moose>)
#song(<vingklippta_masen>)
#pagebreak()

#insert-virtual-pages(1)
#song(<den_jagade_masen>)
#song(<musen>)
#place(
  center + bottom,
  dx: 0mm,
  dy: 7mm,
  image(width: 75%, "/song_book/assets/images/klotformad-råtta.png"),
)
#pagebreak()

 #text(size: subheader-size)[Byten]
#song(<vi_aro_sma_humlor_vi>)
#song(<den_digitala_snapsvisan>)
#song(<sill_och_ansjovis>)
#pagebreak()

#text(size: subheader-size)[Biten]
#song(<minnet>)
#song(<borsras>)
#pagebreak()
#skip-pages(1)

 #text(size: subheader-size)[Barstopp]
#song(<toj_hamtegubbar>, after-spacing: 7mm)
#song(<krok_armen_i_vinkel>, after-spacing: 7mm)
#song(<nu_tar_vi_den>, after-spacing: 7mm)
#pagebreak()

#song(<fkane_faft>)
#song(<minne>)
#pagebreak()

 #text(size: subheader-size)[Spökförrådet]
#song(<finska_cykellandslagets_snapsvisa>)
#song(<finsk_snapsvisa>)
#song(<ingmar_bergman>)
#song(<skal>)
#pagebreak()
