#let songbook(title: "Sångbok", subtitle: "", body) = {
  // Configure the page layout (A5 is standard for songbooks)
  set page(
    paper: "a5",
    margin: (top: 2cm, bottom: 2cm, left: 1.5cm, right: 1.5cm),
    numbering: "1",
  )
  
  set text(font: "Liberation Serif", size: 10pt)
  set par(justify: false) // Songs shouldn't be justified

  // Title Page
  align(center + horizon)[
    // text(size: 26pt, weight: "bold")[#title]
    // if subtitle != "" [
    //   v(1em)
    //   text(size: 14pt, italic: true)[#subtitle]
    // ]
  ]
  pagebreak()
  
  // Table of Contents (Index)
  heading(level: 1, numbering: none)[Innehåll]
  outline(title: none, target: heading.where(level: 2))
  pagebreak()

  body
}

// Define the song functions
#let song(title: "", body) = {
  // keepable: false ensures a single song doesn't awkwardly split across pages if it can avoid it
  block(breakable: true, width: 100%)[
    #heading(level: 2, numbering: none)[#title]
    #v(0.5em)
    #body
    #v(2em) // Space after the song
  ]
}

#let songmeta(body) = {
  set text(style: "italic", size: 9pt)
  block(inset: (left: 0.5em), body)
  v(0.8em)
}

#let songtext(body) = {
  set par(leading: 0.7em) // Slightly tighter line spacing for verses
  block(body)
}
