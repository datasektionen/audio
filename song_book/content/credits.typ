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

#contributor-category[Urval av Sånger][
  Dmitri Chirin \
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
  Dmitri Chirin\
  Douglas Fischer\
  Simon Kåhre\
  Leonard Smedberg\
  Erik Sparr\
  Rasmus Söderhielm\
  Marcus Sörberg\
  Alvin Yang\
]

#colbreak()

#box[#contributor-category[Illustrationer][
  Kei\
  Albin Haraldsson\
  Rey Karlander\
  Julia Wang\
]

Stort tack även till alla sångförfattare och
resterande prylmånglerister som hjälpts åt men
inte återfinns i listan ovan!

#v(-0.5em)

#align(center)[
  #image(width: 64.5mm, "/song_book/assets/images/cred-page.png")
  #v(1.5mm)
]]
