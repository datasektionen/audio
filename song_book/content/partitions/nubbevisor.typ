#import "/song_book/template.typ": (
  base-margin, continues-on-next-page, partition-page, song, song-notes,
  insert-virtual-pages
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
#pagebreak()

#continues-on-next-page()
#song(<om_cykling>, text-spacing: 13pt)
#song(<mera_jarn>)
#pagebreak()

#song(<imbelupet>)
#pagebreak()

 #text(size: subheader-size)[Qvarten]
#song(<grav_ur_tundran>)
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
#continues-on-next-page()
#song(<masen>)
#song(<datalogen>)
#pagebreak()

#song(<jasen>)
#song(<the_moose>)
#song(<vingklippta_masen>)
#pagebreak()

#insert-virtual-pages(1)
#song(<musen>)
#song(<den_jagade_masen>)
#pagebreak()

 #text(size: subheader-size)[Byten]
#song(<vi_aro_sma_humlor_vi>)
#song(<den_digitala_snapsvisan>)
#song(<nu_tar_vi_den>)
#pagebreak()

#song(<minnet>)
 #text(size: subheader-size)[Biten]
#song(<borsras>)
#pagebreak()

#song(<vad_ska_vi_gora_med_supen>)
#song(<sill_och_ansjovis>)
#pagebreak()

 #text(size: subheader-size)[Barstopp]
#song(<toj_hamtegubbar>)
#song(<krok_armen_i_vinkel>)
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

