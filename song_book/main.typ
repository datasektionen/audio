#import "/song_book/template.typ": (
  base-margin, song, song-book, table-of-contents,
)

#show: song-book

#include "/song_book/content/book-owner-page.typ"

#include "/song_book/content/starkt-är-vackert-page.typ"

#table-of-contents()

#include "/song_book/content/partitions/introduktion.typ"

#include "/song_book/content/ovve-guide-frack-guide.typ"

#include "/song_book/content/partitions/gasquesånger.typ"

#include "/song_book/content/partitions/datasånger.typ"

#include "/song_book/content/partitions/sektionssånger.typ"

#include "/song_book/content/partitions/sånger-till-ölet.typ"

#include "/song_book/content/partitions/sånger-till-vinet.typ"

#include "/song_book/content/partitions/punschvisor.typ"

#include "/song_book/content/partitions/nubbevisor.typ"

#include "/song_book/content/partitions/dagen-efter.typ"

#include "/song_book/content/partitions/traditionellt.typ"

#include "/song_book/content/partitions/högtid.typ"

#include "/song_book/content/partitions/säsånger.typ"

#include "/song_book/content/partitions/roliga-sånger.typ"

#include "/song_book/content/partitions/egna-sånger.typ"

#include "/song_book/content/partitions/register.typ"

#include "/song_book/content/credits.typ"

#include "/song_book/content/bucket-list.typ"
