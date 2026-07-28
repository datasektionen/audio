#import "/song_book/template.typ": (
  base-margin, checkbox-square, insert-virtual-pages, partition-page, song,
  song-notes,
)

#insert-virtual-pages(9)
#[
  #set document(title: [Datalogens guide till Overall och Högtidsdräkt])

  //#set heading(numbering: "1.1.")

  #set page(margin: (top: base-margin + 1pt, bottom: base-margin - 1pt))
  #set par(leading: 4pt, spacing: 0.2in)
  #set text(size: 11pt, hyphenate: true)
  
  #set list(marker: (sym.bullet, sym.bullet.hyph))

  #let checklist(content) = {
    set list(marker: checkbox-square())

    content
  }

  = Guide till overallen
  == Ovven

  Overallen, eller Ovven som den ofta kallas, är bland de mest ärofyllda plaggen som en Datalog kan bära. Datasektionens overaller är cerise. Vissa andra missförstår färgen som rosa, röd eller till och med orange, men tro inte på dem. De är bara färgblinda.

  == Märken
  Märken är tyglappar som pryder din ovve.
  De kan visa saker som vilken sektion och nämnd du tillhör, vilka event du har varit på, vem du har bytt märken med, och sist men inte minst vad du tycker är roligt.

  == Speciella märken
  Det finns vissa märken som har en speciell plats på ovven _(se nästa sida)_:
  + KTH-märket, som  sitter på vänster överarm.
  + Sektionsmärket, som sitter över hjärtat, alltså på vänster sida av bröstet.
  + Årskursmärket, som sitter över hjärtat$#[]^(-1)$, alltså på höger sida av bröstet.
  #box[
  4. NØlleraden, som är de märken som erhölls under mottagningen, ska sitta i en vertikal rad på vänster ben, med det tidigaste eventet längst ner och nØllegasquemärket längst upp. Mottagningsmärket ska sitta över nØlleraden.
  #v(-0.5em)
  _En tradition inom data är att ha vänster ben för eventmärken, följ den gärna om du känner för det!_
  #v(-0.5em)

  == Ovvenamn
  - Ovvenamnet är ditt namn eller ett smeknamn som du fått av någon annan.
  - Ovvenamnet ska sitta på framsidan av \ overallens högra ben.

  #align(center + horizon)[#v(-4mm) #image("/song_book/assets/images/ovve-black.svg", width: 70mm)]
  ]
  #pagebreak()

  == Att sy på märken
  Märken skall sys med nål och tråd för hand dock aldrig genom kransen och datasigillet på ovvens rygg.
  #v(-0.5em)
  #text(style: "italic")[För att få märken att sitta hårt rekommenderas stark tråd, mest använd är "björntråd".]

  == Tvätt

  - Din ovve tvättas endast då du är i den.
  - Exempel på tvättplatser är: i en sjö, i havet, i en fontän, duschen, eller en mycket stor tvättmaskin.
  - Prylmångleriet ordnar en gemensam ovvetvätt som kallas Plask varje sommar.

  == Tips & tricks
  - Det ryms mycket i ovvens många fickor, men för att få extra plats kan man med fördel knyta en knut längst ut på ärmarna och sedan förvara större saker i dem.
  - På den vänstra nedre sidofickan (även kallad sångboksfickan) finns leverantörsmärket, detta är din ovveoslkuld. Man får endast rycka av den med tänderna men var uppmärksam om andra försöker ta den!
  - Vill man ytterligare dekorera sin ovve kan man fästa saker som maskotar, capshanddukar (vad är caps? Fråga någon gammal), kapsylöppnare, lasersvärd, osv. osv. på sin ovve.

  // For some reason having the "Twitter Color Emoji" font also be confgured
  // breaks some of the hyphenation... 😖
  #set text(font: "Libertinus Serif")
  == Andra sektioners sektionsplagg

  Ibland när du är ute på campus, eller står i kön till en pub, kan du stöta på studenter klädda i overaller som inte är cerise. Märkligt, tänker du säkert. Men oroa dig inte, dessa är bara studenter som inte är dataloger. Det kan vara bra att lära känna de andra sektionernas overallfärger också, så att du inte verkar ignorant när du är ute och är social.

  Notera att vissa sektioner bär B-frack. Dessa är: Doktorandsektionen (Dr), Flygsektionen (T), Maskinsektionen (M), och Sektionen för Medieteknik (Me). Bergssektionen (B) bär grå jaquette, något som är unikt för dem.

  #box[
    == Byte av ovvedel
    Något som är vanligt bland overallare är byte av delar på ovven. Olika sektioner, föreningar och lärosäten har olika regler för detta. Nedan följer några vanliga regler:

    - Att byta arm med någon betyder att man är nära vänner.
    - Att byta bakfickor betyder att man gått bakvägen med personen. Detta kan tolkas fritt.
    - Att byta krage betyder att man är i ett förhållande med personen.

    _Det bör även tilläggas till denna guide att det är din egen ovve i grund och botten och att du gör vad du vill, hur du vill med den. Mycket nöje!_
  ]
  #pagebreak()


  #box[
    = Guide till högtidsdräkten

    Högtidsdräkt är den mest formella av alla svenska klädkoder, inte bara i studentsammanhang utan även allmänt i livet. Därför är det av ytterst vikt att Datalogen, när hen blir bjuden till ett evenemang med denna klädkod, har god förståelse för klädkodens etiquette och delar.
    
    När klädkoden är högtidsdräkt bär man balklänning, frack, folkdräkt, mässdräkt eller prästrock. Denna guide kommer endast beröra de två förstnämnda, för information om de andra dräkterna hänvisas läsaren till sin favoritsöktjänst

    #pad(x: base-margin, bottom: -8mm)[#align(center + bottom)[#image("/song_book/assets/images/sangbok-Hogtidsdrakt-transparent.png", height: 75mm)]]
  ]
  #pagebreak()
  == Schmecken
  Till högtidsdräkt i studentikosa sammanhang bör teknologen bära teknologmössa. På KTH är teknolgmössan kallad schmeck, och färgen på kullen och plösen beror på typ av ingenjör, grå för civilingenjör och lila för högskoleingenjör.

  Schmecken har en svart tofs som är fäst på dess högra sida. På snöret till tofsen ska det sitta spegater, en för varje påbörjat läsår. Datasektionens spegat är cerise och köpes från Prylmångleriet. 
  
  Schmecken har också en THS-krokard på mössbandet som köps separat; fråga nån gammal hur man fäster den.

  == Utmärkelser
  Allmänt gäller att man ska ha max tre frackband samtidigt och bandet för den största organisationen som man är del av sitter överst. För de flesta Dataloger innebär detta alltså THS kårband överst, och eventuella sektionsband under kårbandet.

  #pagebreak()

  === Utmärkelser för fracken
  Medaljer ska fästas på frackkavajen, över den vänstra fickan. När medaljer bärs ska näsduk inte bäras.
  
  Pins fästs normalt på slaget, dock kan de även fästas på plösen men detta är mindre formellt.

  På en frack ska frackbandet löpa från höger axel till vänster höft, innanför västen. 
  #v(-0.5em)
  #text(style: "italic")[Tips: Frackband kan fästas med hjälp av säkerhetsnålar, eller med nål och tråd.]
  #box[#v(0.5em)
  === Utmärkelser för balklänningen
  Medaljer och pins placeras på vänster sida, förslagsvis tillsammans med eventuella frackband. Pins kan även mindre formellt fästas på plösen.

  Då Datalogen önskar bära frackband till balklänning, ska detta knytas i en rosett och nålas fast på klänningens vänstra sida, antingen i brösthöjd eller i höjd med midjan. Frackbandet ska fästas så att det inte nuddar huden.
  #v(3em)
  #place(center, dy: -4em)[#align(center)[#image("/song_book/assets/images/frackband.png", height: 56mm)]]]

  #pagebreak()

  == Fracken
  En frack har väldigt många delar som man måste ha koll på. Nedan följer en lista, som är i ordningen som blir lättast när man ska ta på sig fracken.
  #v(-0.5em)

  #text(size: 10pt, checklist[
    - Frackskjorta
    - Strumpor
    - Bröst- och manschettknappar
    - Fluga
    - Frackbyxor
    - Hängslen
    - Frackväst
    - Ev. frackband
    - Ev. fickur
    - Frackkavaj
    - Pins och (Näsduk eller ev. medaljer)
    - Lackskor
    - Schmecken
  ])
  #v(-0.5em)
  #text(style: "italic")[Datalogen kan med fördel använda denna lista som handledning eller inköpslista.]

  === Detaljer
  Vid studentikosa evenemang ska frackskjortan, västen och flugan vara vita, om inget annat specificeras. Frackkavaj och frackbyxor ska vara svarta eller djupt midnattsblå, och ha samma material som varandra. Strumporna ska vara svarta och lackskor eller finskor i läder ska bäras därtill.

  #v(-0.5em)
  #text(style: "italic")[Tips: Se till att du inte skrynklar kavajens svansar när du sätter dig ned.] 
  
  == Balklänningen
  Utformningen av balklänningen har mycket större valfrihet jämfört med fracken. De enda reglerna är som följer:
  + Materialet ska vara lyxigt och/eller festligt.
  + Klänningen måste gå hela vägen till golvet. 
  === Accessoarer
  - Om silkeshandskar bärs ska de täcka armbågarna. Man bär aldrig ringar utanpå handskar.
  - En handväska är praktiskt då balklänningar sällan har fickor. Bär gärna en handväska som matchar din klänning och dubblar som accessoar. Både handväska med och utan axelrem är OK.
  - Skorna ska ha stängd tå och vara fina, dvs. ej sneakers eller idrottsskor. Klack eller inte spelar ingen roll.
]