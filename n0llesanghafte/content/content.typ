#import "../template.typ" : remove-page-numbering

#include "mottagningsinfo.typ"

#include "songs.typ"

#pagebreak()
// Skips a lot of pages because we don't want page numbers for personalen
#remove-page-numbering(99)

#include "personalen.typ"

#include "page-padding.typ"

#include "last-page.typ"

#context {
  let pages = counter(page).get().at(0)
  let remainder = calc.rem(pages, 4)
  assert(remainder == 0, message: "The page count is not divisable by 4, current count: " + str(pages) + ".\n Add " + str(4 - remainder) + " or remove " + str(remainder) + " page(s).")
}