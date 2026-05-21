#import "template.typ": songbook, song, songmeta, songtext

#show: songbook.with(
  title: "Den Stora Sångboken",
  subtitle: "En samling för alla tillfällen"
)

// --- SONGS START HERE ---

#include "Gasquesånger/gasquesonger.typ"
#include "Datasånger/datasanger.typ"
#include "Sektionssånger/sektionssanger.typ"
#include "Sånger till Ölet/songer_till_ol.typ"
#include "Sånger till Vinet/songer_till_vinet.typ"
#include "Punschvisor/punchvisor.typ"
#include "Nubbevisor/nubbevisor.typ"
#include "Dagen efter/dagen_efter.typ"
#include "Traditionellt/traditionellt.typ"
#include "Högtid/hogtid.typ"
#include "Säsånger/sasanger.typ"
#include "Roliga Sånger/roliga_sånger.typ"
