#let gender-marker(number) = {
  let gender-symbol = text(
    size: 0.8em,
    baseline: -0.3em,
    style: "normal",
    [⚧],
  )
  
  [#gender-symbol#super(number)]
}
