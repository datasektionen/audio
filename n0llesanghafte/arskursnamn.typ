#let arskurser() = {
  let data = json("data/meta.json").years
  let entries = data.values()
  let extra-space = 2em

  let mid = calc.ceil(entries.len() / 2)
  let col1 = entries.slice(0, mid)
  let col2 = entries.slice(mid)
  
  pad(left: 5mm)[
    #grid(
      columns: (1fr, 0.7fr),
      stroke: none,
      align: (left, left),
      row-gutter: 0.4em,
      gutter: -4.0em,
      ..range(mid).map(i => (
        [#col1.at(i).year#h(extra-space)#col1.at(i).name],
        if i < col2.len() [
          #col2.at(i).year#h(extra-space)#col2.at(i).name
        ] else [],
      )).flatten()
    )
  ]
}