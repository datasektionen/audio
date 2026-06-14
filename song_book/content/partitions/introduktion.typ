#import "/song_book/template.typ": (
  base-margin, footnote-entry, insert-virtual-pages, partition-marker,
  table-of-contents,
)

#partition-marker[Introduktion]

#[
  // For some reason these pages seem to be shifted down a tiny amount in the
  // original PDF...
  #set page(margin: (top: base-margin + 1pt, bottom: base-margin - 1pt))
  #set par(leading: 4pt, spacing: 0.2in)
  #set text(size: 11pt, hyphenate: true)

  = Förord

  Hej och välkommen till den sjunde upplagan av #box[/dev/audio], Konglig Data-?sektionens Sångbok. Efter en ytterst intensiv termin kan du härmed läsa denna sångbok!

  Det vi uppnått under denna vår hade inte varit möjligt utan den grupp engagerade själar som kan återfinnas i slutet av boken, alla dessa förtjänar de största utav tack. Jag vill även rikta ett speciellt tack till Rasmus Söderhielm och Alvin Yang i deras särskilt enorma engagemang i skapandet av denna sångbok, utan dessa två hade projektet inte kunnat färdigställas eller inte ens påbörjas. 

  Om du hittar en bugg i boken, maila #box[#link("mailto:prylis@datasektionen.se")] så kanske du får ett exklusivt märke som tack.

  14 juni 2026\
  David Lindkvist\
  Quadragesimus Tertius\
  Sångboksansvarig 2026, PUNG 26/27\


  #insert-virtual-pages(1)
  #pagebreak()

  #include "/song_book/content/könade-ord.typ"
  #pagebreak()

  = Datasektionens historia

  Den 7 oktober 1983 bildades Konglig Data-?sektionen i och med att de första sextio data-?teknologerna höll det första sektionsmötet. Ur protokollet kan man notera att bland de saker som diskuterades fanns sektionens färg, symbol och maskot. Intressant är att den färg som länge diskuterades var brunt, denna färg ansågs dock alltför förknippad med en viss annan rörelse som hade sin storhetstid under 40-talet nere på kontinenten. Khaki hann också bli nedröstat innan sektionen till slut kunde enas om att #strike[rosa] cerise\* var den absolut käckaste färgen man kunde ha på overallerna. Sektionens symbol blev först lilla frakturdeltat, men den ändrades till lilla deltat då man insåg att frakturdelta inte är någonting som existerar i sinnevärlden. Någonting som tyvärr fallit i glömska är att sektionen även fick en maskot, lusen.

  NØllningen 1983 togs om hand av Fysik samt Elektro, och D-sektionen fick även därifrån grun-?den till sina första stadgar. De första åren delades även studievägledningen med Fysik. De tre första hedersmedlemmarna i Konglig Data-?sektionen, Johan Groth (F), Katrin Rosenqvist (F) samt Ste-?fan Östlund (E) var aktiva i bildandet av Konglig Data-?sektionen och mottagandet av Primus.

  #v(1fr)
  #footnote-entry[\*Datasektionens officiella färg är i hex: \#E83D84]
  #v(4.5pt)


  Eftersom sektionen, till personantalet, var mycket liten de första åren (60 intagna per år de fyra första åren) blev sammanhållningen mycket god eftersom alla kände alla, och många engagerade sig därför i sektionsarbetet.

  Med en sektion finns också ett behov av ett klubbmästeri, och vips så var DKM skapade. Den första traditionella Djulfesten hölls i december 1983, en tradition som finns kvar än idag.

  1984 blev det dags för Data att få en sektions-?lokal. Efter ett långt år utan en plats att vara på fick Data äntligen en lokal på Osquars Backe 27, som döptes till ESCapen. Även om lokalen var väldigt liten, fanns det ett antal finurliga utrym-?men. Det fanns till exempel ett loft, som användes som ett öllager. Bland de första åtgärderna i den nya lokalen var att inordna en liten hörna där den trötte teknologen kunde inhandla kaffe, läsk och godis till ett facilt pris. Hörnan kallades Hederlige Stures efter sin grundare, som brukade ta tunnel-?banan till en godisgrossist och därifrån återvända dignande av diverse stimulantia för natthackande teknologer. En funktionärspost vid samma namn skapades efter en sida i dbuggen med Stures bild och rubriken ”Skulle du handla av den här mannen”, samt bildtexten ”Hederlige Sture”. Hederlige Sture har under årens lopp efterträtts av nya Hederliga Sturar och inrättningen lever fortfarande kvar nu i form av posten HSE inom METAdorerna.

  Samma år var det dags för Datasektionens första egna mottagning. Med inspiration från Fysik delades mottagningen upp i Drifveriet och Dadde-?riet. Drifveriet bestod av 12 män i vita västar, med piskor som symbol, och endast Konglig Öfverdrif med mustasch. Dadderiet bestod av ungefär 10 kramgoa personer i cerisa snickarbyxor. Även DKM var med och hjälpte till, med ungefär 10 personer de också. Eftersom sektionen den hösten endast bestod av 40-50 personer kunde alla som ville få vara med och arrangera nØllningen. Trots att intaget av nya medlemmar fyrdubblats under årens gång, så har Mottagningens intag av perso- nal inte följt samma trend.

  Mycket av den första Mottagningen improvi-?serades, och till exempel så var Nattorientering först tänkt att hållas utomhus. Några av station-?er-?na var ölhäfv på höjd, pricka med pappersflygplan,#h(-3pt) och pricka rätt med tavel-?svamp, där man skulle fånga en tavelsvamp fallandes från hög höjd med en soptunna. Denna lek togs sedan bort efter flertalet skador på nØllan. Det första jubileet ägde rum 1985, då Data firade två år. Anledningen till detta var att många andra sektioner hade jubi-?leum, och temat var barnkalas. dbuggen skapades efter 1985 års vårbal, och finns kvar än idag som den mest oseriöst seriösa tidningen på KTH. Det var även det här året Drifveriet blev 9 i antal. Under åren har sektionslokalen flyttats runt på campus. Första flytten blev till Osquars Backe 4, 
  
  #pagebreak()

  som traditionsenligt döptes om till 27. 1991 sked-?de andra flytten till Osquars Backe 10, som igen döps om till 27 och för att hålla reda på lokalen tillsätter Konglig Lokalchef Escapenkommitten, vilket var företrädaren till METAdorerna. Detta år skapades även posten Sektionshistoriker. ESCa-?pen får sedan 1992 flytta ihop med elektro i en barrack på DKV 27. Drifveriets piskor avskaffas snabbt efter en insändare till Osqledaren.

  1993 är det dags för 10-års jubi-?leum och eftersom jubi-?leum ofta blir stökiga, införde SM nØllestädning, vilket innebar att de nya fick städa ESCapen i ett år framåt. Det här året sattes även Dataspelet upp för första gången, som senare slogs ihop med Media och blev till METAspexet 2011, med första föreställning 2012. Året efter får ESCapen sin sista viloplats på Osquars Backe 8 (27). 1995 ändras sektionens namn från Kongliga Datasektionen till Konglig Datasektionen.

  Åren går och till slut så flyttar Datasektionen ihop med Sektionen för Medieteknik och blir sambos 2011. Lokalen döps till META efter en knapp vinst över Tilde. 2015 så friar Datasektio-?nen till Sektionen för Medieteknik och gifter sig kort därpå.

  #footnote-entry[
    Vill du läsa mer historia? Spana in #link("damm.datasektionen.se")\
    Douglas Fischer & Axel Elmarsson -- Sektionshistoriker 2021/2022
  ]

  #insert-virtual-pages(11)
]
