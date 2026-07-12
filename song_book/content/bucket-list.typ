#import "/song_book/template.typ": checkbox-square

#{
  show heading.where(level: 1): set text(size: 12pt, weight: "bold")
  show heading.where(level: 1): it => pad(left: -9pt, it)
  [= Gasque- och sång-bucketlist]
}

#let bucket-list-item(
  body,
  squares: 1,
  square-size: 8pt,
  square-color: black,
  square-line-width: 0.5pt,
  after-spacing: -0.7em
) = {
  set text(size: 10pt)
  grid(columns: (..range(squares).map(_ => auto), 1fr),
    gutter: 4pt,
    align: horizon,
    ..range(squares).map(_ => align(top + left)[
      #checkbox-square()
    ]),
    body
  )
  v(after-spacing)
}

#v(-0.4em)
#box[
  #align(left, pad(left: -9pt, right: -20pt, bottom: -10pt)[
      #bucket-list-item(squares: 5)[Framför gyckel på 5 olika gasquer.]
      #bucket-list-item[Framför 3 gyckel på samma gasque utan att bli #linebreak() utburen.]
      #bucket-list-item[Bli utburen när du gycklar.]
      #bucket-list-item[Bli utburen då du inte slutar sjunga ”Ett nØll ett” #text(style: "italic")[(s.48)].]
      #bucket-list-item[Skriv en egen sång #text(style: "italic")[(s.186)] och framför den på en gasque.]
      #bucket-list-item[Var först med att ropa "Hörde jag vikingen?" på en gasque.]
      #bucket-list-item[Starta ”Vikingen” #text(style: "italic")[(s.16)] genom att svara ”Att du gjorde!”]
      #bucket-list-item[Sjung varje sång i sångboken #text(style: "italic")[(s.0-185.b)].]
      #bucket-list-item[Var sångledare för ”Kalmarevisan” #text(style: "italic")[(s.20)].]
      #bucket-list-item[Sjung ”Nuskaviklämma...” #text(style: "italic")[(s.183)] snabbare än en prylmånglerist. \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ (underskrift)]
      #bucket-list-item[Sjung ”Gaffeln” #text(style: "italic")[(s.19)] med en ny melodi.]
      #bucket-list-item[Drick ingen alkohol på en sittning och sjung ”Jag #linebreak() ser ni krökar” #text(style: "italic")[(s.19)] till de som gör det.]
      #bucket-list-item[Bli tackad med "En liten blå förgätmigej" #text(style: "italic")[(s.34)] som personal på en sittning.]
      #bucket-list-item[Sjung ”Konglig Datasektionens Sektionssång” #text(style: "italic")[(s.39)] på #linebreak() en annan sektions (eller studentorganisations) sittning.]
      #bucket-list-item[Sjung ”Bordeaux, Bordeaux” #text(style: "italic")[(s.89)] medan du dricker Bordeaux (eller alkoholfritt alternativ).]
      #bucket-list-item[Sjung starkast av alla i någon sång (Starkt är vackert).]
      #bucket-list-item[Avkoda den binära koden under “Konglig Datasektionens Sångbok” och utför instruktionerna.]
      #bucket-list-item(after-spacing: -0.6em)[Få boken signerad av 5 personer på föregående uppslag.]

      #h(10pt) 
      #box[#text(style: "italic", size: 9pt,)[Den som kan uppvisa och försvara 19 ikryssade rutor kan köpa ett exklusivt märke hos Prylis...]]
    ]
  )
]
