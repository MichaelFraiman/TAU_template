// LISTS
// numbering with letters
#let enum_l(..items) = {
  enum(
    numbering: {
      (..nums) => {
        set text(
          weight: "extrabold"
        )
        numbering("a.", nums.pos().first())
      }
    }
  ,
  ..items)
}

#let enum_cond(..items) = {
  enum(
    numbering: {
      (..nums) => {
        set text(
          weight: "extrabold"
        )
        numbering("1.", nums.pos().first())
      }
    }
  ,
  ..items)
}

// numbering with no indentation
#let enum_big(
  spacing: 1em,
  ..items) = {
  enum(
    numbering: {
      (..nums) => {
        if nums.pos().len() == 1 {
        set text(weight: "extrabold")
        "("
        nums.pos().map(str).first()
        ")"
        } else {
          "("
          set text(weight: "bold")
          nums.pos().map(str).first()
          "."
          set text(weight: "medium")
          nums.pos().slice(1).map(str).join(".")
          ")"
        }
      }
    },
    full: true,
    indent: 0em,
    number-align: start + top,
    spacing: spacing,
    tight: false,
    ..items
  )
}

// inline numbering
#let rr(
  counter,
  value: none,
  pts: none
) = [#{
  text(weight: "bold", style: "normal")[#{
    "("
    if value == none {
      counter.step()
      counter.display()
    } else {
      str(value)
    }
    if pts != none {
      text(weight: "regular")[#{", " + pts + " points"}]
    }
    [)]
  }]
}]

#let list_bull(
  spacing: 1em,
  ..items
) = {
  list(
    marker: sym.diamond.filled,
    spacing: spacing,
    tight: false,
    ..items
  )
}

#let ur(
  t,
  marker: sym.diamond.filled
) = text(style: "italic")[
    #smallcaps[#{
      marker + [~] + t
    }]
  ]

#let enum_col(
  columns: (1fr),
  indent: 0em,
  counter_inline,
  ..items
) = {
  let i = ()
  for item in items.pos() {
    i.push({
      h(indent)
      rr(counter_inline) + item
    })
  }
  grid(
    columns: columns,
    row-gutter: 1em,
    ..i
  )
}