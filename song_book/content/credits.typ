#import "/song_book/template.typ": base-margin

#set text(size: 11pt)
#set par(leading: 4pt)

#show: pad.with(x: -1pt)

#let contributor-category(title, people) = {
  set par(hanging-indent: 5pt)
  text(weight: "bold", title) + linebreak()
  people

  v(5.2mm, weak: true)
}

#v(2mm)

#contributor-category[Projektledare (och lite allt möjligt)][
  David Lindkvist\
]

#contributor-category[Design (och lite allt möjligt)][
  Max Wippich\
]

#contributor-category[Urval av Sånger][
  Dmitry Chirin \
  David Lindkvist \
  Rasmus Söderhielm\
]

#contributor-category[Övriga Texter i Boken][
  Douglas Fischer\
  Kristin Mickols\
  Erik Nordlöf\
  Adam Sjöberg\
  Alvin Yang\
]

#contributor-category[JML-Genomgång][
  Rasmus Söderhielm\
]

#contributor-category[Korrekturläsare][
  #v(-1.2em)
  #table(columns: (4cm, auto), stroke: none,
  [
    Dmitry Chirin\
    Douglas Fischer\
    Simon Kåhre\
    Leonard Smedberg\
  ],
  [
    Erik Sparr\
    Rasmus Söderhielm\
    Marcus Sörberg\
    Alvin Yang\   
  ])
]

#colbreak()

#box[#contributor-category[Illustrationer][
  #v(-1.2em)
  #table(columns: (4cm, auto), stroke: none,
  [
    Kei\
    Douglas Fischer\
    Albin Haraldsson\
    Rey Karlander\ 
  ], 
  [
    Kristin Mickols\
    Adam Sjöberg\
    Julia Wang\
  ])
]

Stort tack även till alla sångförfattare och
resterande prylmånglerister som hjälpts åt men
inte återfinns i listan ovan!

Och ännu ett stort tack till Max Wippich, Erik Nordlöf och Douglas Fischer i deras enorma ursprungliga arbete vilket denna upplaga är baserad på.

#v(-0.5em)

#align(center)[
  #image(width: 45.5mm, "/song_book/assets/images/cred-page.png")
  #v(1.5mm)
]]
