//! The book owner page

#let margin = 9.2mm

#set page(margin: (x: margin, bottom: margin, top: 6.5mm))
#set heading(outlined: false)
#show heading: set text(size: 26pt)
#show heading: set align(center)
#set par(leading: 0em, spacing: 0em)
= Boken tillhör:
#v(3mm, weak: true)

#let field-label(body) = text(body, size: 12pt, weight: "bold")
#let field-description(body) = text(body, size: 10pt, style: "italic")
#let field-margin = 10mm

#grid(columns: (auto, 1fr), gutter: 2mm)[
  #set align(center)
  #set par(spacing: 3pt)

  #let stroke-width = 2pt
  #rect(
    width: 37mm,
    height: 50mm,
    outset: -stroke-width / 2,
    stroke: black + stroke-width,
  )

  #text(size: 10pt, style: "italic")[(Självporträtt)]
][
  #show: block.with(height: 50mm)
  #set par(leading: 5pt)
  #field-label[Namn:]\
  #field-description[(t.ex. Osquar, Quristina)]
  #v(field-margin)

  #field-label[Årskurs & Årskursnamn:]\
  #field-description[(t.ex. D-83, Primus)]
  #v(field-margin)

  #field-label[Favoritspråk:]\
  #field-description[(t.ex. Prolog, Scratch, Japanska)]
  #v(field-margin)
]

#v(3mm)

#grid(columns: (auto, 1fr), gutter: 2mm)[
  #image(height: 66mm, "/song_book/assets/images/dnd-stats.svg")
][
  #set align(left + top)
  #set par(leading: 5pt)
  #field-label[Favoritsorteringsalgoritm:]\
  #field-description[(t.ex. Quacksort)]
  #v(field-margin)

  #field-label[Favoritsång:]\
  #field-description[(t.ex. Jag vill aldrig gå på Handels)]
  #v(field-margin)

  #block[
    #field-label[Favoritfärg:]\
    #field-description[(Cerise)]
    #v(field-margin)

    #place(
      top + left,
      dx: 15mm,
      dy: 7mm,
      // You need to have this font installed
      text(size: 9mm, font: "Shadows Into Light Two")[Cerise],
    )
  ]

  #align(right, text(size: 12pt)[
    Om bortappad, kontakta mig på:
  ])
]

#pagebreak()
