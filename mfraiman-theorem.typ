
#let theorem(
    c, // counter
    body,
    name: "Theorem",
    note: none,
    les_num: none,
    les_num_symb: "",
    body_style: "italic",
    numbered: true,
    name_func: smallcaps
  ) = {
    if numbered == true {c.step()}
    set text(weight: "black")
    name_func(name)
    if numbered == true {
      [ ]
      if ( les_num == none ){
        context counter(heading).at(here()).first()
      } else {les_num}
      les_num_symb + [.] + c.display("A") }
    if note != none { text(weight: "medium")[ (#smallcaps(note))] }
    [.]
    text(style: body_style, weight: "regular")[#body]
  }