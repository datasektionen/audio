#import "/song_book/template.typ": (
  base-margin, continues-on-next-page, partition-page, song, song-notes
)

// Title page
#partition-page[Sånger till vinet][
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Sånger till vinet
  #v(1fr)
  #v(-5pt)
  #align(center, pad(
    x: -base-margin,
    image(width: 85% - 15pt, "/song_book/assets/images/100winestwo.png"),
  ))
  #v(1fr)
]

=== Vinskola

#let list-style = (first-line-indent: (amount: 6pt, all: true), leading: 0.5em)
#let list-spacing = 0em
#text(size: 10.1pt)[
  #par(..list-style)[
    #text(style: "italic")[Öl är för barbarer, vin är för civiliserade.] 
    #linebreak()
    Liknande uttalanden har gjorts i tusentals år, med ett möjligt ursprung i antika Grekland. Huruvi-#linebreak()da det stämmer är svårt att säga. Människan har druckit vin i över 8000 år, men somliga tycks ännu inte ha behärskat konsten. Vingliga steg, jobbiga bakfyllor och roliga historier är bara några av konsekvenserna, resten får du upptäcka själv.  
  ]

  #par(..list-style)[
    De fem huvudsakliga vintyperna är indelade efter färg respektive framställningsmetod:
  ]
  #v(list-spacing)
  #par(..list-style)[
    #text(weight: "bold")[Röda viner:] Mellanröda till mörkt purpurfärgade viner som är gjorda på blå druvor. När rött vin jäser finns kärnor och skalet från druvan kvar. Smakmäs-sigt kan man generellt säga att röda viner är mer fylliga och komplexa än vita viner.
  ]
  #v(list-spacing)
  #par(..list-style)[
    #text(weight: "bold")[Vita viner:] Ljust färgade viner som oftast är gjorda på gröna druvor. Till skillnad från rött vin avlägsnas kärnor och skalet från druvan vid jäsning.
  ]
  #v(list-spacing)
  #par(..list-style)[
    #text(weight: "bold")[#strike[Rosé]Ceriseviner:] Ett flertal metoder finns för att skapa dessa viner men resultatet hamnar någon-#linebreak()stans mellan rött och vitt, cerise helt enkelt.
  ]
  #v(list-spacing)
  #par(..list-style)[
    #text(weight: "bold")[Mousserande viner:] Viner som innehåller kolsyra, ofta från jäsning eller tillsättning av koldioxid. Alla viner kan bli mousserande, men vanligast är vita mousserande vin eller mousserande #strike[rosé]cerisevin.
  ]
  #v(list-spacing)
  #par(..list-style)[
    #text(weight: "bold")[Starkviner:] Viner med hög alkoholhalt, oftast 15 till 22 volymprocent. Den höga alkoholhalten upp-#linebreak()nås med en tillsats av destillerad druvsprit. Starkvin kan vara vitt, rosécerise eller rött.
  ]

  #par(..list-style)[
    Vindruvan är världens mest planterade frukt och det odlas fler blå druvor än gröna. Smaken på vinet beror på olika druvor, olika regioner, olika blandningar med mera.
    #linebreak()
    #linebreak()
    Skulle vi beskriva alla vinsorter här hade denna boken blivit väldigt tung.
  ]
]

#song(<bordeaux_bordeaux>)
#pagebreak()

#box[
  #song(<feta_fransyskor>)
  #v(-2.6em)
  #align(center, 
  [
    #pad(left: 1.6em)[
    #image("/song_book/assets/images/feta_fransyskor.png", width: 90%)]
  ])
]
#pagebreak()

#song(<elysisk_langtan>)
#song(<imsig_vimsig>)
#place(
  center + bottom,
  dx: -13mm,
  dy: 15mm,
  image(width: 100%, "/song_book/assets/images/Sid 91 spoderims.svg"),
)
#pagebreak()

#continues-on-next-page()
#song(<fredmans_sang_no_35>)
#pagebreak()

#song(<vinets_lov>)
#pagebreak()

#song(<varvinets_lov>)
#song(<som_en_blomma>)
#pagebreak()
