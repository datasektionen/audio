#import "template.typ" : song-book,remove-page-numbering

#let namn = sys.inputs.at("namn", default: "*[NAMN]*")

#song-book(background: none)[
  #remove-page-numbering(2)
  #pagebreak()
  
  #align(center)[#pad(top: 15mm)[#text(size: 30pt)[Jag heter#linebreak()#namn#linebreak()och trots att#linebreak()jag tappat bort#linebreak()mitt vackra och minst#linebreak()sagt ovärderliga#linebreak()sånghäfte har jag#linebreak()fått ett nytt och fint#linebreak()som jag är inte så#linebreak()lite stolt över.]]]
]