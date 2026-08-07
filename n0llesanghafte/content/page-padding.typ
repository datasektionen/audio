//! Contains a context that automatically adds empty
//! pages to the end of the song-book to make the
//! page count divisible by 4.
#import "../template.typ"

#context {
  let pages = counter(page).get().at(0) + 1
  let remainder = calc.rem(pages, 4)

  // Anchor: without some content preceding the conditional here,
  // Typst mis-resolves this context block's page-count query and
  // inserts extra pagebreaks even when remainder == 0. An invisible
  // zero-size box is enough to stabilize it.
  box()

  if remainder != 0 {
    let pages-to-add = 4 - remainder
    for i in range(pages-to-add) {
      pagebreak()
    }
  }
}