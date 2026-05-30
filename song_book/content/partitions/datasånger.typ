#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Datasånger][
  #show: block.with(width: 100%, breakable: false)
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Datasånger
  #v(-4.2mm)
  #align(center, pad(
    x: -base-margin,
    top: 15pt,
    image(width: 88mm, "/song_book/assets/images/Datorsånger.png"),
  ))
]

// årskursvisan panikar av någon anledning
//#song(<arskursvisan>, text-spacing: 3.4mm)

//=== Det var i vår ungdoms fagraste vår
//#set text(style: "italic", size: 10pt)
//Melodi: Trad.
//#v(0em)

#box(
  [
    #song(<arskursvisan>)
    #v(-1.9em)
    Alla så dricka vi nu \"D-Osquarina\"\* till.
    #v(-0.8em)
    #text(weight: "bold")[Och \"D-Osquarina\" vi säger inte nej därtill.]
    #v(-0.8em)
    För det var i vår ungdoms fagraste vår,
    #v(-0.8em)
    vi drack varandra till och vi sade gutår!

    #song-notes(
      "D-Osquarina utbytes lämpligen mot årskursnamn, \r\n”gästerna” och eventuellt ”personalen”.\r\n\r\nVartefter Konglig Datasektionens årskurser fick längre och längre namn, innebar det en större utmaning att hinna sjunga ”Och alla så dricka vi nu…”. Därför föreslås följande sätt att sjunga längre-än-tvåstaviga namn:",
    )
    #v(0.5em)
    - #text(style: "italic")[
        ”Och alla vi dricka D-Osquarina till”
        #v(-0.8em)
        (Ex: dovicesimus)
      ]

    - #text(style: "italic")[
        ”Och alla, drick D-Osquarina till”
        #v(-0.8em)
        (Ex: dodevicesimus)
      ]

    - #text(style: "italic")[
        ”Och alla, nu drick D-Osquarina till”
        #v(-0.8em)
        (Ex: vicesimus quartus)
      ]
  ],
)
#pagebreak()

//\r\n\r\n\r\n\r\n\r\n

//</li>\r\n</ul><p>Årskursnamn hittills</p>1983,\tprimus\r\n1984,\tsecundus\r\n1985,\ttertius\r\n1986,\tquartus\r\n1987,\tquintus\r\n1988,\tsextus\r\n1989,\tseptimus\r\n1990,\toctavius\r\n1991,\tnonus\r\n1992,\tdecimus\r\n1993,\tundecimus\r\n1994,\tdodecimus\r\n1995,\ttertius decimus\r\n1996,\tsigvard\r\n1997,\tquintus decimus\r\n1998,\tsextus decimus\r\n1999,\tseptus decimus\r\n2000,\tdodevicesimus\r\n2001,\tundevicesimus\r\n2002,\tvicesimus\r\n2003,\tunvicesimus\r\n2004,\tdovicesimus\r\n2005,\ttertius vicesimus\r\n2006,\tvicesimus quartus\r\n2007,\tvicesimus quintus\r\n2008,\tvicesimus sextus\r\n2009,\tvicesimus septus\r\n2010,\tduodetricesimus\r\n2011,\tundetricesimus\r\n2012,\ttricesimus\r\n2013,\tuntricesimus\r\n2014,\tduotricesimus\r\n2015,\ttricesimus tertius\r\n2016,\ttricesimus quartus\r\n2017,\ttricesimus quintus\r\n2018,\ttricesimus sextus\r\n2019,\ttricesimus septimus\r\n2020,\tduodequadragesimus\r\n2021,\tundequadragesimus\r\n2022,\tquadragesimus\r\n2023,\tunquadragesimus
=== Årskursnamn hittills

#set text(size: 10pt)
#let extra-space = 1em
#align(center, pad(left: -2.0mm, right: -10.0mm, table(
  columns: (1fr, 1fr),
  stroke: none,
  align: (left, left),
  row-gutter: -0.5em,
  gutter: -4.0em,
  [1983,#h(extra-space)primus],           [2008,#h(extra-space)vicesimus sextus],
  [1984,#h(extra-space)secundus],         [2009,#h(extra-space)vicesimus septus],
  [1985,#h(extra-space)tertius],          [2010,#h(extra-space)duodetricesimus],
  [1986,#h(extra-space)quartus],          [2011,#h(extra-space)undetricesimus],
  [1987,#h(extra-space)quintus],          [2012,#h(extra-space)tricesimus],
  [1988,#h(extra-space)sextus],           [2013,#h(extra-space)untricesimus],
  [1989,#h(extra-space)septimus],         [2014,#h(extra-space)duotricesimus],
  [1990,#h(extra-space)octavius],         [2015,#h(extra-space)tricesimus tertius],
  [1991,#h(extra-space)nonus],            [2016,#h(extra-space)tricesimus quartus],
  [1992,#h(extra-space)decimus],          [2017,#h(extra-space)tricesimus quintus],
  [1993,#h(extra-space)undecimus],        [2018,#h(extra-space)tricesimus sextus],
  [1994,#h(extra-space)dodecimus],        [2019,#h(extra-space)tricesimus septimus],
  [1995,#h(extra-space)tertius decimus],  [2020,#h(extra-space)duodequadragesimus],
  [1996,#h(extra-space)sigvard],          [2021,#h(extra-space)undequadragesimus],
  [1997,#h(extra-space)quintus decimus],  [2022,#h(extra-space)quadragesimus],
  [1998,#h(extra-space)sextus decimus],   [2023,#h(extra-space)unquadragesimus],
  [1999,#h(extra-space)septus decimus],   [2024,#h(extra-space)douquadragesimus],
  [2000,#h(extra-space)dodevicesimus],    [2025,#h(extra-space)quadragesimus tertius],
  [2001,#h(extra-space)undevicesimus],    [2026,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
  [2002,#h(extra-space)vicesimus],        [2027,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
  [2003,#h(extra-space)unvicesimus],      [2028,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
  [2004,#h(extra-space)dovicesimus],      [2029,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
  [2005,#h(extra-space)tertius vicesimus],[2030,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
  [2006,#h(extra-space)vicesimus quartus],[2031,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
  [2007,#h(extra-space)vicesimus quintus],[2032,#h(extra-space)\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_],
)))
#set text(size: 11pt)

#pagebreak()

#box(
  [
    #song(<datas_bordsvisa>)
    #v(-3em)
    #align(center, image(width: 86%, "/song_book/assets/images/Dog Poker table shadow.png"))
  ],
)
#pagebreak()

#box(
  [
    #song(<konglig_datasektionens_sektionssang>)
    #v(-1em)
    #song(<nar_examen_viskar_mitt_namn>)
  ],
)
#pagebreak()

#box(
  pad(right: -3pt, song(<den_kodbestrodde_norden>))
)
#pagebreak()

#song(<avslag_pa_csn>)
#pagebreak()

#song(<brev_fran_kongligen>)
#pagebreak()

#song(<en_kvall_i_meta>)
#pagebreak()

#box(
  [
    #song(<prylmanglerister>)
    #song(<np_inte_p>)
  ],
)
#pagebreak()

#box(
  [
    #text(size: 10.8pt, song(<jag_vill_va_som_du>)) // Jag vill "ju" var' som du borde det väl vara
  ],
)
#pagebreak()

#song(<dataeliten>)
#pagebreak()

#song(<bredbandshymn>)
#pagebreak()

#box(
  [
    #song(<mors_lilla_dator>)
    #song(<ett_noll_ett>)
  ],
)
#pagebreak()

#song(<till_emacs>)
#pagebreak()

#set page(margin: (bottom: 3cm))
#song(<write_in_c>)

// Here is a pagebreak I dont want

#block(breakable: false)[
  #song(<the_basic_song>)
  #text(font: "Consolas", size: 10.7pt)[ // Ta bort detta och lägg till alternativ till annan font för #song()
    #v(-2.5em)
    10 LET oss nu fatta i våra glas
    #v(-0.6em)
    20 INPUT en klunk utav det som där has
    #v(-0.6em)
    30 IF du fått nog THEN till 50 min vän
    #v(-0.6em)
    40 ELSE GOTO-baka till 10 igen
    #v(-0.6em)
    50 END
    #v(0.5em)
  ]

  #song-notes("Samtliga kommandon följs. Inledande radnummer kan antingen utelämnas eller utropas av en ledsångare, på vars lott det i så fall faller att avgöra när ”du fått nog”. BASIC konstruerades 1963 och akronymen utläses ”Beginner’s All-purpose Symbolic Instruction Code”.")
]
#pagebreak()
#set page(margin: (x: base-margin, y: base-margin))

#pad(right: -1pt, song(<matlab>, text-notes-spacing: 14pt, notes-leading: 3pt, notes-spacing: 2.5mm))

#v(-1mm)

#song(<systeme_interweb>)
#pagebreak()

#song(<du_nya_du_frascha>) // Kommentar behöver uppdateras i enlighet med djubileumsupplagan
#song(<datalogik>)
#pagebreak()
