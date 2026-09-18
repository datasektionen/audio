#import "template.typ" : song-book, remove-page-numbering

#let namn = sys.inputs.at("namn", default: "*[NAMN]*")

#song-book(background: none)[
  #remove-page-numbering(2)
  #pagebreak()
  
  #align(center)[#pad(top: 15mm)[#text(size: 30pt)[Jag heter#linebreak()#namn#linebreak()och trots att#linebreak()jag bara är en#linebreak()schlemm och#linebreak()whÿdrough nØllan#linebreak()så har jag fått#linebreak()ett sånghäfte#linebreak()som jag är mäkta#linebreak()stolt över.]]]
]