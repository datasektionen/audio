#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Nubbevisor][
  #show: block.with(width: 100%, breakable: false)
  #v(4.2mm)
  = #h(6pt) Nubbevisor
  #v(-4.2mm)
  #align(center, pad(
    left: -base-margin - 5mm,
    top: 2pt,
    image(width: 130mm, "/song_book/assets/images/nubbevisor.png"),
  ))
]

#box[
  = Helan
  #song(<helan_gar>)
  #song(<hell_and_gore>)
]
#pagebreak()

#box[
  #song(<denna_thaft>)
  = Halvan
  #song(<tank_om_jag_hade>)
]
#pagebreak()

#song(<ode_till_halvan>)
#song(<ratt_lyft>)
#pagebreak()

= Tersen
#song(<can_can>)
#pagebreak()

#song(<om_cykling>, text-spacing: 13pt)
#song(<mera_jarn>)
#pagebreak()

#song(<imbelupet>)
#pagebreak()

= Qvarten
#song(<grav_ur_tundran>)
#pagebreak()

#song(<detta_glas>)
#song(<en_gang_i_manan>)
#pagebreak()

= Qvinten
#song(<fordom_odlade_man>)
#song(<magen_brummar>)
#pagebreak()

#box[
  #song(<lilla_manasse>)
  #song(<kors>)
]
#pagebreak()

= Sexten
#song(<vodka_vodka>)
#song(<angbaten>)
#pagebreak()

= Måsen
#song(<masen>)
#song(<datalogen>)
#pagebreak()

#song(<jasen>)
#song(<the_moose>)
#song(<vingklippta_masen>)
#pagebreak()

= Byten
#song(<vi_aro_sma_humlor_vi>)
#song(<den_digitala_snapsvisan>)
#song(<nu_tar_vi_den>)
#pagebreak()

#song(<minnet>)
= Biten
#song(<borsras>)
#pagebreak()

#song(<vad_ska_vi_gora_med_supen>)
#song(<sill_och_ansjovis>)
#pagebreak()

= Barstopp
#song(<toj_hamtegubbar>)
#song(<krok_armen_i_vinkel>)
#pagebreak()

#song(<fkane_faft>)
#song(<helangorakatt>)
#pagebreak()

= Spökförrådet
#song(<finska_cykellandslagets_snapsvisa>)
#song(<finsk_snapsvisa>)
#song(<ingmar_bergman>)
#song(<skal>)
#pagebreak()

