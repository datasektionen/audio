#import "/song_book/template.typ": (
  continues-on-next-page, base-margin, footnote-entry, partition-page, song,
  song-notes, insert-virtual-pages
)

// Title page
#partition-page[Gasquesånger][
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Gasquesånger
  #v(1fr)
  #v(-5pt)
  #align(center, pad(
    x: -base-margin,
    image(width: 100% - 15pt, "/song_book/assets/images/gasquesånger.png"),
  ))
  #v(1fr)
]

#[
  #set par(leading: 4pt)
  #set text(size: 10.5pt)
  == Gasqueskola
  #v(4pt, weak: true)

  // TODO: Change page numbers to references

  Gasque kan betyda väldigt olika saker beroende på vem du frågar, men denna text handlar om hur dataloger på KTH ser på saken. En gasque är en ”fulsittning”, vilket betyder vad det låter som. Om man jämför med en banquette (finsittning) där porslinet, besticken, musiken, klädseln och stämningen är väldigt pryda och fina; ser man stor skillnad. Musiken är mer vardaglig, klädseln är ovve/b-frack, porslin och bestick är billigt (ofta engångs) och stämningen är mer avslappnad. I regel finns 1-2 toastmaster som för sittningen framåt, bestämmer sånger som sjungs med mera.

  Hur brukar det då gå till på en gasque? Efter att alla deltagare anlänt precis lagom sent hör du att någon börjar trumma i bordet. Några andra hänger på. Till slut sitter alla och trummar, och gör något skumt ljud som slutar i ett crescendo. ”TEMPO”, ropar alla samtidigt som trummandet slutar. Toast-?master ställer sig då upp och börjar prata, gasquen är igång! På Data inleds en gasque oftast med att ”Trippeln” (s.14) sjungs. Trippeln består av de tre låtarna ”Porthos visa”, ”Skitåkare Andersson” och ”Hej på er bröder alla”, vilka sjungs direkt efter varandra.

  Cykeln är sedan ungefär att toastmaster ställer sig upp för att presentera maten, säga vad som ska sjungas, eller presentera ett gyckel. Efter varje tem-?po får alla sittande tid att prata med varandra, äta och dricka, tills nästa tempo startas.

  Ett gyckel är en kort föreställning, teater, en sång som framförs eller nästan vad som helst, som sittande vanligtvis kan anmäla hos en toastmaster under sittningens gång. Är ett gyckel tråkigt eller för långt är det sedvanligt att räcka upp handen. Om tillräckligt många sittande räcker upp handen kan dessa ställa sig upp och bära ut den eller de som gycklar, från sittningen. Efter ett gyckel sjungs ”Tackvisan” (s.28) som tack till den/dem som gycklat.

  En viktig komponent på varje gasque är punsch. Pusnch serveras vanligtvis efter dessert och då sjungs den lämpliga varianten av ”Punschen kommer” (s.97). Man fortsätter sjunga denna samtidigt som man gör olika rörelser, tills det att punsch man fått. När punschen småningom är slut och din flaska blivit tom, så sjungs ”Sista punschvisan” (s.104).

  När gasquen nått sitt slut ropas ”Hallå personalen!” och man går ner på ett knä, tills personalen ställer sig på rad framför de sittande, varpå ”En liten blå förgät-?migej” (s.34) sjungs som tack till de de som jobbat.

  #place(
    center,
    dy: 0mm,
    image(width: 80%, "/song_book/assets/images/gåsque.png"),
  )
]
#pagebreak()

#song(<porthos_visa>, text-spacing: 3.4mm, after-spacing: 3mm)

#let hagagatan-three() = {
  text(fill: rgb("#c5c5c5"))[8]
  h(-0.42em)
  [3]
}

#context {
  show "3": it => hagagatan-three()
  pad(bottom: -8mm, song(<skitakare_andersson>, text-spacing: 3.4mm))
}

#pagebreak()
#place(
  center + bottom,
  dx: -0.5mm,
  dy: 5mm,
  image(width: 70%, "/song_book/assets/images/trippeln-nohead.png"),
)

#song(<hej_pa_er_broder_alla>, text-spacing: 3.4mm)

#pagebreak()
#place(center + bottom, dx: 1.5mm, dy: 3.5mm, pad(
  x: -base-margin,
  image(width: 95%, "/song_book/assets/images/viking.png"),
))

#song(<vikingen>)
#pagebreak()

#insert-virtual-pages(2)
#box[
  #song(<feministvikingen>, text-spacing: 8pt)
  #v(-16pt)
  #song(<nykteristvikingen>, text-spacing: 8pt)
]
#pagebreak()

#box[
  #song(<kapitalistvikingen>, meta-text-spacing: 8pt, text-notes-spacing: 8pt, text-spacing: 8pt)
  #v(-17pt)
  #song(<pacifistvikingen>, meta-text-spacing: 8pt, text-notes-spacing: 8pt, text-spacing: 8pt)
]
#pagebreak()

#song(<solen>)
#song(<korta_solen>)
#song(<norrlandska_sommarsolen>)
#pagebreak()

#song(<jag_ska_festa>)
#pagebreak()

#song(<gaffeln>)
#song(<jag_ser_ni_krokar>)
#place(
  right + bottom,
  dx: 32mm,
  dy: 9mm,
  image(width: 110%, "/song_book/assets/images/Sid 18 jungelmannen_card.svg"),
)
#pagebreak()

#song(<kalmarevisan>, text-spacing: 0.204in, after-spacing: 5mm, add-after-nth-par: ((
  5,
  pagebreak(),
),))
#song(<festen_ska_borjas>)
#pagebreak()

#song(
  <harjarevisan>,
  add-after-nth-par: ((
    3,
    place(bottom + left, footnote-entry[
      #super[⚧]Original: och blir en man från hår till häl.
    ])
  ),),
  override-notes-content: [
    Ur Lundaspexet ”Djingis Khan”, 1954.\
    Endast andra och tredje versen härrör ur spexet ifråga. Den förstas ursprung är okänt.
  ]
)
#song(<livet_ar_harligt>)
#pagebreak()

// Why is it jar? 😭
#song(
  <nar_jar_ar_fuller>,
  after-spacing: 0.2in,
  add-after-nth-par: ((2, pagebreak() + v(-1.3mm)),),
)
#song(<spritbolaget>, meta-text-spacing: 8pt)
#pagebreak()

#song(<dom_som_ar_fulla>)
#pagebreak()

#song(<dom_som_ar_nyktra>, after-spacing: 0.2in)
#song-notes[
  Sångerna på detta uppslag sjunges parallellt. De som\
  dricker alkohol sjunger "Dom som är nyktra" medan de\
  som dricker alkoholfritt sjunger "Dom som är fulla".
]
#pagebreak()

#song(<wenngarn>, text-notes-spacing: 3mm)
#place(dy: 3.5mm, song(<tackvisan>, text-notes-spacing: 3mm))
#pagebreak()

#song(<uti_min_mage>)
#pagebreak()

#song(<jag_har_aldrig_vart_pa_snusen>, meta-text-spacing: 2.9mm)
#pagebreak()

#song(<handels_visa>, meta-text-spacing: 3mm)
#pagebreak()

#song(<fysiks_visa>, meta-text-spacing: 3mm, text-spacing: 5.3mm)
#pagebreak()

#place(song(<datas_visa>, meta-text-spacing: 3mm, text-spacing: 5.3mm))
#pagebreak()

#insert-virtual-pages(4)

#place(song(<medias_visa>, meta-text-spacing: 3mm, text-spacing: 5.3mm))
#pagebreak()

#song(
  <mattes_visa>,
  meta-text-spacing: 5mm,
  text-size: 10pt,
  text-leading: 3.5pt,
  text-spacing: 14.0pt,
)
#pagebreak()

#place(song(<cls_visa>, meta-text-spacing: 3mm, text-spacing: 5.3mm))
#pagebreak()

#song(
  <merge-conflictens_visa>,
  text-spacing: 4mm,
  text-notes-spacing: 4mm,
  after-spacing: 4mm,
  override-nth-par: ((
    4,
    [
      Datan är grå -- och mera öl\
      Datan är trist -- och mera öl\
      Datan är skit -- och mera öl\
      Och mera öl\
      #v(-1cm)
    ]
  ),),
  add-after-nth-par: ((
    4,
    continues-on-next-page(),
  ),)
)

#song(<raj_raj>, meta-text-spacing: 3mm, text-notes-spacing: 4mm, after-spacing: 4mm)
#song(<en_liten_bla_forgatmigej>, meta-text-spacing: 3mm, text-notes-spacing: 4mm,)
#pagebreak()
