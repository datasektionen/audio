#import "../template.typ" : remove-page-numbering, personalen-data, titel-meta, meta-data, find-person, get-current-page-number

#let branch-title(name) = {
  align(center)[
    #text(size: 20pt)[*#name*]
  ]
}

#let person-entry(
  data,
  margin-y: 2.5mm,
  image-width: 0.83in,
  hide-image: false,
) = {
  box[
    #h(margin-y)
    #box(width: 0.83in)[
      #if not hide-image {
        let image-manifest = json("../data/personalen images/manifest.json")
        let image-url = if image-manifest.keys().contains(data.kth_username) {
          "../data/personalen images/" + image-manifest.at(data.kth_username)
        } else {
          "../data/personalen images/" + image-manifest.at("placeholder")
        }
        image(image-url, width: 0.83in)
      }
      #text(size: 10pt)[#data.name]
    ]
    #h(margin-y)
  ]
}

#let titel-name(data, height: auto) = {
  h(1fr)
  box(width: 0.83in, height: height)[
    #text(style: "italic", size: 10pt)[#data.name]
  ]
  h(1fr)
}

// Splits an array into chunks of `size` — each chunk becomes one row.
#let chunk(arr, size) = {
  range(0, arr.len(), step: size).map(i => arr.slice(i, calc.min(i + size, arr.len())))
}

// How many person-entries fit comfortably across one row.
// Tune this to your actual page width / entry width.
#let entries-per-row = 4



// Mottagningen
#align(center + horizon)[
  #text(size: 50pt)[#text(style: "italic")[Mottagningen \ #meta-data.current_year]]
  #v(20mm)
]

// Titel
#pagebreak()
#align(center + horizon)[
  #branch-title("Titel")
  #v(5mm)
  #h((titel-meta.top-padding-x-mm) * 1mm)
  #stack(dir: ltr)[
    #for id in titel-meta.at("top kth-ids") {
      titel-name(find-person(id))
    }
  ]
  #h((titel-meta.top-padding-x-mm) * 1mm)
  #v(titel-meta.top-text-spacing-mm * 1mm)
  #image("../data/titel images/titel.jpg", width: 4.46in)
  #stack(dir: ltr)[
    #h((titel-meta.bottom-padding-x-mm) * 1mm)
    #for id in titel-meta.at("bottom kth-ids") {
      titel-name(find-person(id))
    }
    #h((titel-meta.bottom-padding-x-mm) * 1mm)
  ]
]
#pagebreak()
 
#let remove-titel(raw-personal) = {
  let personal = ()
  for person in raw-personal {
    if person.title == none {
      personal.push(person)
    }
  }
  return personal
}

// Render all branches except dadderiet
#for (branch, raw-personal) in personalen-data {
  if branch == "Dadderiet" {
    continue
  }

  let personal = remove-titel(raw-personal)

  v(2em)

  let rows = chunk(personal, entries-per-row)
  let first-row = rows.at(0, default: ())
  let rest-rows = rows.slice(1)

  align(center)[
    // Title + first row: locked together as one unbreakable unit,
    // so they always move to the next page as a pair rather than
    // the title ever being orphaned alone at the bottom of a page.
    #block(breakable: false)[
      #branch-title(branch)
      #pad(x: 5mm)[
        #stack(dir: ltr, spacing: 1em, ..first-row.map(person-entry))
      ]
    ]

    // Remaining rows: ordinary breakable blocks, free to flow
    // across as many pages as needed.
    #for row in rest-rows {
      pad(x: 5mm, top: 5mm)[
        #stack(dir: ltr, spacing: 1em, ..row.map(person-entry))
      ]
    }
  ]
}

// Render Dadderiet

#let get-daddegroups() = {
  let daddegroups = (:)
  let dadderiet-personal = personalen-data.at("Dadderiet")
  for person in dadderiet-personal {
    if person.n0llegroup_name == none {
      continue
    }
    let group-members = daddegroups.at(person.n0llegroup_name, default: ())
    group-members.push(person)
    daddegroups.insert(person.n0llegroup_name, group-members)
  }

  let sorted-groups = daddegroups.pairs().sorted(key: pair => pair.at(0)).to-dict()
  return sorted-groups
}

#let daddegroup-box(group-name, members) = {
  box[
    #pad(x: 5mm, top: 5mm)[
      #box(fill: color.silver, width: 1fr, height: 5mm)[#align(horizon)[#text(size: 12pt)[*#(group-name)*]]]
      #stack(dir: ltr, spacing: 1em, ..members.map(person-entry))
    ]
    #v(-2mm)
  ]
}
#align(center)[
  #let daddegroups = get-daddegroups()
  
  // First group and branch title
  #let group-a-name = daddegroups.keys().first()
  #let group_a-members = daddegroups.values().first()
  #box[
    #branch-title("Dadderiet")
    #v(-6mm)
    #daddegroup-box(group-a-name, group_a-members)
  ]

  #for (group-name, members) in daddegroups {
    if group-a-name == group-name {
      continue
    }
    daddegroup-box(group-name, members)
  }
]