#import "../template.typ" : (song, remove-page-numbering, personalen-data, meta-data)

#let titel-member(data) = box[
  #v(1em)
  #par(justify: true)[
    #text(size: 17pt)[
      #data.title #data.name #h(1fr) #data.phone
    ]
  ]
]

#remove-page-numbering(1)

#align(center)[#pad(top: 30mm)[
  #image("../resources/doqumenteriet.png")
  #v(1.5em)
  #text(style: "italic", size: 20pt)[Följ mottagningen!]
  #v(-0.5em)
  #text(size: 17pt, spacing: 2.5mm)[Se alla mottagningsbilder på]
  #linebreak()
  #v(-0.9em)
  #text(size: 17pt)[https://dsekt.se/mottagningsbilder]
]]
#pagebreak()


#align(center)[
  #pad(top: 40mm)[
    #text(17pt)[*Telefonnummer till Daddetitel*]
  ]
]

#pad(x: 2mm)[
  #stack(dir: ttb)[
    #let daddor = ()
    #for (branch, value) in personalen-data {
      if meta-data.daddetitel_branches.contains(branch) {
        daddor = daddor + value
      }
    }

    #let daddetitel = ()
    #for dadda in daddor {
      if  dadda.title != none {
        if dadda.title.starts-with("Stor") {
          daddetitel.insert(0, dadda)
        } else {
          daddetitel.push(dadda)
        }
      }
    }

    #for member in daddetitel {
      titel-member(member)
    }
  ]
]