#import "/song_book/template.typ": base-margin, partition-page, song, song-notes

#partition-page[Sånger till ölet][
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Sånger till ölet
  #v(1fr)
  #v(-5pt)
  #align(center, pad(
    x: -base-margin,
    top: 15pt,
    image(width: 90%, "/song_book//assets/images/till_ölen.png"),
  ))
  #v(1fr)
]

#let list-style = (first-line-indent: (amount: 6pt, all: true), leading: 0.5em)
#let list-spacing = -0.5em

=== Ölskola

#v(-0.4em)
#text(style: "italic", size: 10pt)[Mel: lansup]
#set text(size: 10.1pt, )
#par(..list-style)[
  Öl delas normalt in i två huvudkategorier med hänsyn till tillverkningsförfarandet; under- eller överjästa öl. Den vanligaste metoden är under- jäsning, där jästen sjunker till karets botten efter avslutad jäsning. Vid överjäsning används en jäst som ligger kvar på ytan då jäsningen är klar. Inom dessa två kategorier återfinns följande ölsorter:
]
#v(-0.3em)
#par(..list-style)[
  #text(weight: "bold")[Lager:] Samlingsnamnet för samtliga underjästa öl. Står i Sverige ofta för ett ljust öl med mild humlesmak. Med andra ord ett lättdrucket öl.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Pils:] Underjäst, mycket ljust öl med stor beska. Pilsner Urquell från Pilzen i Tjeckien anses vara ur-pilsen.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Bayersk:] Underjäst öl med sitt ursprung i Tyska Bayern. Ölet är halvmörkt och med en rostad karaktär.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Ale:] Överjäst öl med varierande färg frän ljus-brunt eller kopparbrunt till svart. Smaken är oftast fruktig. Ale är ett typiskt engelskt öl men tillverkas också bland annat i Belgien.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[IPA:] Den förmodligen mest kända stilen av ale. Väldigt vanlig bland mikrobryggerier och kontro-versiell när det kommer till smakåsikter.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Alt:] Överjäst öl frän Düsseldorfregionen i Tysk-land. Det är ett fylligt, kopparfärgat öl med en lätt rostad karaktär.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Porter:] Överjäst, nästan svart öl med en utpräglad rostad smak. Den finns i både söta och torra varianter.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Stout:] Överjäst, nästan svart öl. Smaken är kraftigt rostad, torr och rejält besk. Påminner om porter men är kraftigare i karaktären. Den mest kända stouten är Guinness.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Veteöl:] Överjäst öl där minst 50% av malten
kommer från vete. Det finns ljusa, mörka, klara och
grumliga veteöl.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Geuze:] Spontanjäst Belgiskt veteöl. Jäsningen startas med hjälp av jästpartiklar som finns naturligt i luften.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Kriek:] I princip en Geuze som smaksatts med
körsbär.
]
#v(list-spacing)
#par(..list-style)[
  #text(weight: "bold")[Cider:] Inte öl.
]
#set text(size: 11pt)

#song-notes([
  Generellt bör överjästa öl serveras med temperaturer från 10°C till rumstemperatur. Underjästa öl bör i allmänhet serveras svalare, 8-10°C. Riktigt smakrika underjästa öl kan serveras en aning varmare.
])

#align(center + horizon)[
  #image("/song_book/assets/images/ölflaskor.png")
]
#pagebreak()

#song(<lapin_kulta>)
#song(<ju_mera_ol_vi_dricker>)
#pagebreak()

#song(<olfyllarvisan>)
#song(<for_olet_ar_djavla_gott>)
#pagebreak()

#song(<en_pilsnerdrickare>)
#song(<strejk_pa_pripps>)
#pagebreak()