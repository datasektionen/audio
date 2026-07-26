#import "/song_book/template.typ": (
  base-margin, footnote-entry, partition-marker, table-of-contents,
)

#partition-marker[Introduktion]

#[
  // For some reason these pages seem to be shifted down a tiny amount in the
  // original PDF...
  #set page(margin: (top: base-margin + 1pt, bottom: base-margin - 1pt))
  #set par(leading: 4pt, spacing: 0.2in)
  #set text(size: 11pt, hyphenate: true)

  = Förord

  Hej och välkommen till den sjunde upplagan av #box[/dev/audio], Konglig Data-?sektionens sångbok. Efter en ytterst intensiv vår och sommar kan du härmed läsa denna sångbok!

  Från att gräva upp gamla filer från forna datalogers datorer, till att trillskas med programvara ej känd för dess användarvänlighet, till att helt enkelt få nog och göra om hela boken i Typst. Ja, denna resa har varit intressant måste jag säga. 

  Jag vill rikta ett speciellt tack till Rasmus Söderhielm, som i princip helt på egen hand konverterade boken från InDesign till Typst(!), och Alvin Yang, som kämpade för att pränta ner i detalj en av de största delarna av vår studentkultur; allt om våra kära ovveraller!

  Såklart finns ännu fler att tacka för deras arbete, alldeles för många för att nämnas på denna sida, så istället kan de återfinnas i slutet av boken!

  Om du hittar en bugg i boken, maila #box[#link("mailto:prylis@datasektionen.se")] så kanske du får ett exklusivt märke som tack.

  26 juli 2026\
  David Lindkvist\
  Quadragesimus Tertius\
  Sångboksansvarig 2026, PUNG 26/27\

  #pagebreak()

  #include "/song_book/content/könade-ord.typ"
  #pagebreak()

= Datasektionens historia

  Den 7 oktober 1983 bildades Konglig Datasektionen i och med att de första sextio datateknologerna höll det första sektionsmötet. Ur protokollet kan man notera att bland de saker som diskuterades fanns sektionens färg, symbol och maskot. Den färg som länge diskuterades var brunt, dock ansågs denna färg vara alltför starkt förknippad med en viss annan rörelse som hade sin storhetstid runt 40-talet. Khaki hann också bli nedröstat innan sektionen till slut kunde enas om att #strike[rosa] cerise\* var den absolut käckaste färgen man kunde ha på overallerna. Sektionens symbol blev först det lilla frakturdeltat, men ändrades kort därpå till det lilla delta då man insåg att frakturdelta inte är någonting som existerar i sinnevärlden. Något som tyvärr fallit i glömska är att sektionen även fick en maskot, lusen.

  NØllningen 1983 sköttes av Fysik samt Elektro. Det var även därifrån Datasektionen fick grunden till sina första stadgar. De första åren delades studievägledningen med Fysik. Datasektionens hedersmedlemskap tilldelades Johan Groth (F), Katrin Rosenqvist (F) samt Stefan Östlund (E) för deras engagemang i bildandet av Datasektionen och mottagandet av Primus.

  #v(1fr)
  #footnote-entry[\*Datasektionens officiella färg är i hex: \#E83D84]
  #v(4.5pt)


  Eftersom sektionen, till personantalet, var mycket liten de första åren (60 intagna per år de fyra första åren) blev sammanhållningen mycket god eftersom alla kände alla, och många engagerade sig därför i sektionsarbetet.

  Med en sektion finns också ett behov av ett klubbmästeri, och vips så var DKM skapade. Den första traditionella Djulfesten hölls i december 1983, en tradition som finns kvar än idag.

  1984 blev det dags för Datasektionen att få en egen sektionslokal. Efter ett långt år utan eget tillhåll fick Datasektionen äntligen en lokal på Osquars Backe 27, som döptes till ESCapen. Även om lokalen var väldigt liten, fanns det ett antal finurliga utrymmen. Det fanns till exempel ett loft, som användes som öllager. Bland de första åtgärderna i den nya lokalen var att inordna en liten hörna där den trötte teknologen kunde inhandla kaffe, läsk och godis till ett facilt pris. Hörnan kallades Hederlige Stures efter sin grundare, som brukade ta tunnelbanan till en godisgrossist och därifrån återvända dignande av diverse stimulantia för natthackande dataloger. En funktionärspost vid samma namn skapades efter en sida i dbuggen med Stures bild och rubriken ”Skulle du handla av den här mannen”, samt bildtexten ”Hederlige Sture”. Hederlige Sture har under årens lopp efterträtts av nya Hederliga Sturar och inrättningen lever fortfarande kvar inom METAdorerna.

  #pagebreak()


  Samma år var det dags för Datasektionens första egna mottagning. Med inspiration från Fysik delades mottagningen upp i Drifveriet och Dadderiet. Drifveriet bestod av 12 män i vita västar med piskor som symbol, och endast Konglig Öfverdrif med mustasch. Dadderiet bestod av ungefär 10 kramgoa personer i cerise snickarbyxor. Även drygt 10 personer från DKM var med och hjälpte till. Eftersom sektionen den hösten endast bestod av 40–50 personer kunde alla som ville få vara med och arrangera mottagningen.

  Mycket av den första mottagningen improviserades, till exempel var Nattorienteringen först tänkt att hållas utomhus. Några av stationerna var ölhäfv på höjd, kasta pappersflygplan och pricka rätt med tavelsvamp, där man skulle fånga en tavelsvamp fallandes från hög höjd med en soptunna. Denna lek togs sedan bort efter flertalet skador på nØllan. Det första jubileet ägde rum 1985, då Datasektionen firade två år med tema barnkalas. Anledningen till detta var att många andra sektioner hade jubileum. dbuggen skapades efter Vårbalen 1985, och finns kvar än idag som den mest oseriöst seriösa tidningen på KTH. Det var även det året Drifveriet blev 9 till antalet.

  Under åren har sektionslokalen flyttats runt på campus. Första flytten blev till Osquars Backe 4, som traditionsenligt döptes om till 27. 1991 skedde andra flytten till Osquars Backe 10, som igen döptes om till 27 och för att hålla reda på lokalen tillsätter Konglig Lokalchef Escapenkommitten, vilket var företrädaren till METAdorerna. Detta år skapades även posten Sektionshistoriker. ESCapen får sedan 1992 flytta ihop med elektro i en barack på DKV 27. Samma år avskaffades Drifveriets piskor snabbt efter en insändare till Osqledaren.

  1993 var det dags för 10-års jubileum, och eftersom jubileum ofta blir stökiga införde SM nØllestädning. Det innebar att de nya fick städa ESCapen i ett år framåt. Det här året sattes även Dataspelet upp för första gången, som 2012 döptes om till METAspexet. Året efter får ESCapen sin sista viloplats på Osquars Backe 8 (27). 1995 ändrades sektionens namn från Kongliga Datasektionen till Konglig Datasektionen.

  Åren går utan dokumenterad historia och till slut flyttar Datasektionen ihop med Sektionen för Medieteknik och blir sambos 2011. Lokalen döps till META efter en knapp vinst över Tilde. 2015 så friar Datasektionen till Sektionen för Medieteknik och gifter sig kort därpå.

  #footnote-entry[
    Sugen på mer historia? Spana in #link("damm.datasektionen.se")\
    Douglas Fischer & Axel Elmarsson\
    Sektionshistoriker 2020–2022
  ]
]
