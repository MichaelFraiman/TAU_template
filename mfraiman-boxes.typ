#let slantedBackground(
  color: black,
  text_color: white,
  font: none,
  body
) = {
  set text(
    fill: text_color,
    weight: 700,
  )
  if font != none {set text(font: font)}
  style(styles => {
    let size = measure(body, styles)
    let inset = 8pt
    [#block()[
      #polygon(
        fill: color,
        (0pt, 0pt),
        (0pt, size.height + (2*inset)),
        (size.width + (2*inset), size.height + (2*inset)),
        (size.width + (2*inset) + 6pt, 0cm)
      )
      #place(center + top, dy: size.height, dx: -3pt)[#body]
    ]]
  })
}

#let slantedColorbox(
  title: "title",
  col_back: yellow,
  col_stroke: purple,
  col_title: orange,
  col_text_title: black,
  col_text_body: black,
  radius: 0pt,
  width: auto,
  font_body: none,
  font_title: none,
  font_emoji: none,
  emoji: "",
  body
) = {

  box(
    fill: col_back,
    stroke: 2pt + col_stroke,
    radius: radius,
    width: width
  )[
    #slantedBackground(
      color: col_title,
      text_color: col_text_title,
    )[
      #text(size: 0.8em)[#{
        if font_emoji != none {
          text(font: font_emoji)[#emoji]
        }
      }]
      #text(fill: col_text_title)[#{
        if font_title != none {
          text(font: font_title)[#title]
        }
      }]
    ]
    #block(
      width: 100%,
      inset: (top: -2pt, x: 10pt, bottom: 10pt)
    )[
      #set text(fill: col_text_body)
      #if font_body != none {text(font: font_body)[#body]}
    ]
  ]
}