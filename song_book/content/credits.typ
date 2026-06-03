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

#contributor-category[Design och Projektledare (och lite allt möjligt)][
  Max Wippich\
]

#contributor-category[Urval av Sånger][
  Erik Nordlöf\
  Douglas Fischer\
]

#contributor-category[Övriga Texter i Boken][
  Erik Nordlöf\
  Adam Sjöberg\
  Douglas Fischer\
  Kristin Mickols\
]

#contributor-category[JML-Genomgång][
  Amanda Berg\
  Julia Wang\
  Ebba Bråtman\
]

#contributor-category[Korrekturläsare][
  Jakob Carlsson\
  Douglas Fischer\
  Sara Videfors\
  Kei\
  Kristin Mickols\
  Adam Sjöberg\
]

#v(10mm, weak: true)

Stort tack även till alla sångförfattare och
resterande prylmånglerister som hjälpts åt men
inte återfinns i listan ovan!

#contributor-category[Illustrationer][
  Rey Karlander\
  Julia Wang\
  Kei\
]

#v(1fr)

#align(center)[
  #image(width: 64.5mm, "/song_book/assets/images/cred-page.png")
  #v(1.5mm)
]

