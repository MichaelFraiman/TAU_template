// **** imports ****
// boxes
#import "mfraiman-boxes.typ" as box
// problem setup
#import "mfraiman-problem.typ" as problem
// theorems setup
#import "mfraiman-theorem.typ" as th
// lists
#import "mfraiman-lists.typ" as li

// Global parameters for the handout
#let g_les_num = state("LessonNumber", 0)
#let g_les_date = state("LessonDate", "00.00.2000")
#let g_les_name = state("LessonName", "Hello World!")
#let g_les_name_header = state("LessonNameHeader", "Hello Header!")
#let g_les_num_symb = state("LessonNumberSymbol", "")

#let g_sol_disp = state("SolutionsDisplay", false)
#let g_answ_disp = state("AnswersDisplay", false)

//counters
#let ProblemNumber = counter("ProblemNumber")
#let InlineCounter = counter("InlineCounter")
#let TheoremCounter = counter("TheoremCounter")

//lengths
#let glob_font_size = 11pt
#let glob_baselineskip = glob_font_size * 1.35 //13.6pt
#let glob_b = glob_font_size * 2 //22pt
#let glob_leading = glob_b - glob_baselineskip
#let glob_rel_leading = 0.65em
#let glob_parskip = glob_leading + glob_baselineskip / 2

//global fonts
#let glob_font_rm = state("FontText", "Meta Serif Pro")
#let glob_font_sf = state("FontHead", "Helvetica Neue Pro")

// lists
#let enum_l = li.enum_l
#let enum_big = li.enum_big.with(spacing: glob_b)
#let rr = li.rr.with(InlineCounter)

//Problem setup
#let prob = problem.problem.with(
    ProblemNumber, //counter used to display problem number (ProblemNumber)
    InlineCounter, //InlineCounter
    prob_word: "Problem",
    prob_punct: ".",
    display_answer: locate(loc => {g_answ_disp.at(loc)}),
    display_solution: locate(loc => {g_sol_disp.at(loc)}),
    les_num: locate(loc => {str(g_les_num.at(loc))}),
    les_num_symb: locate(loc => {str(g_les_num_symb.at(loc))})
)

#let ex = problem.problem.with(
    ProblemNumber, //counter used to display problem number (ProblemNumber)
    InlineCounter, //InlineCounter
    prob_word: "Example",
    prob_punct: ".",
    display_answer: locate(loc => {g_answ_disp.at(loc)}),
    display_solution: locate(loc => {g_sol_disp.at(loc)}),
    les_num: locate(loc => {str(g_les_num.at(loc))}),
    les_num_symb: locate(loc => {str(g_les_num_symb.at(loc))})
)

#let theorem = th.theorem.with(
  TheoremCounter,
  name: "Theorem",
  les_num: locate(loc => {str(g_les_num.at(loc))}),
  les_num_symb: locate(loc => {str(g_les_num_symb.at(loc))}),
  body_style: "italic",
  numbered: true
)

#let definition = th.theorem.with(
  TheoremCounter,
  name: "Definition",
  les_num: locate(loc => {str(g_les_num.at(loc))}),
  les_num_symb: locate(loc => {str(g_les_num_symb.at(loc))}),
  body_style: "normal",
  numbered: true
)

#let remark = th.theorem.with(
  TheoremCounter,
  name: "Remark",
  les_num: locate(loc => {str(g_les_num.at(loc))}),
  les_num_symb: locate(loc => {str(g_les_num_symb.at(loc))}),
  body_style: "normal",
  numbered: false,
  name_func: text
)

// default setup
#set math.equation(numbering: "(1)")

//doc style setup
#let conf(
    paper: "a4",
    head_numbering: "1.1.1",
    font_rm: ("Meta Serif Pro", "Noto Serif Hebrew", "Noto Naskh Arabic"),
    font_sf: ("Helvetica Neue LT W1G", "Noto Sans Hebrew", "Noto Sans Arabic"),
    font_tt: ("Noto Sans Mono", "Helvetica Monospaced W1G", "PT Mono"),
    font_math: ("STIX Two Math", "STIX Math"),
    font_header: ("Helvetica Neue LT W1G", "Noto Sans Hebrew", "Noto Sans Arabic"),
    font_footer: ("Helvetica Neue LT W1G", "Noto Sans Hebrew", "Noto Sans Arabic"),
    lang: "en",
    num: 0,
    date: "00.00.0000",
    disp: true,
    name: "Hello World!",
    name_header: "Hello World!",
    num_symb: "",
    part: "Tel Aviv University",
    chapter: "Subject",
    //
    info_file: "info",
    class_id: "00",
    activity: "Plan",
    //
    doc
) = {

  let w_foot_b = "regular"
  let w_foot_l = "extralight"
  let w_foot_th = "thin"
  let w_foot_eb = "bold"

  let w_head_b = "medium"
  let w_head_l = "light"

  let n_top_above = 1 //number of lines above the header
  let n_top_below = 1 // same, but below the header
  let header_font_size = 0.9em

  let n_bottom_above = 1
  let n_bottom_below = 1
  let footer_font_size = 0.75em

  let n_header_height = 0
  let n_footer_height = 0

  //how many lines fit in the paper (REQUIRES A FIX)
  let baselines_num = calc.floor(297mm / glob_baselineskip)
  let paper_excess = 297mm - baselines_num * glob_baselineskip

  set page(
      paper: paper,
      columns: 1,
      margin: (
              left: 2*glob_baselineskip,
              right: 2*glob_baselineskip,
              top: ( n_top_above + n_header_height + n_top_below ) * glob_baselineskip,
              bottom: (n_bottom_above + n_footer_height + n_bottom_below) * glob_baselineskip + paper_excess - 1mm
              // -1 mm is a fix, because otherwise the last line in the text doesn't fit
          ),
      header-ascent: 0%,
    )

  set text(
      font: font_rm,
      lang: lang,
      size: glob_font_size,
      number-type: "lining",
      number-width: "tabular",
      top-edge: "cap-height",
      bottom-edge: "baseline",
      //features: ("calt", "case", "salt"),
      //discretionary-ligatures: true,
      historical-ligatures: true,
      fractions: false,
  )

  set par(
      justify: true,
      linebreaks: "optimized",
      leading: glob_rel_leading
  )


  show par: set block(
    spacing: glob_parskip
  )

  set outline(
      indent: true,
      depth: 4
  )

  set heading(
    numbering: "§ 1."
  )

  show heading.where(
    level: 1
  ): it => locate( loc => {
    block(
      width: 100%,
      above: glob_b,
      below: glob_b,
    )[#{
      set align(left)
      set text(
        1em,
        weight: 900,
        font: font_sf,
        stretch: 100%
      )
      if it.numbering != none {
        counter(heading).display()
        [ ]
      }
      smallcaps(it.body)
    }]
  })
/*
  show heading.where(
    level: 2
  ): it => locate( loc => {
    block(
      width: 100%,
      below: glob_b,
      above: glob_b
    )[#{
    set align(left)
    set text(
      16pt,
      weight: 700,
      font: font_sf
    )
    [§ ]
    locate(loc1 => {
      counter(heading).at(loc1).last()
    })
    [. ]
    smallcaps(it.body)
    }]
  })
*/
  show math.equation: set text(
      font: font_math,
      size: 1.05em
  )

  set enum(
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
    indent: 0.5em,
    number-align: start + top,
    spacing: glob_b * 0.5,
    tight: false
  )

  show figure.caption: set text(size: 0.7em)

  g_sol_disp.update(disp)
  g_les_num.update(num)
  g_les_num_symb.update(num_symb)

  glob_font_rm.update(font_rm)
  glob_font_sf.update(font_sf)

  doc

}



#let br_log() = {
  block(
    width: 100%,
    height: glob_baselineskip,
    //spacing: - 0.5 * glob_baselineskip
  )[
    #align(
      center + horizon,
      text(size: 1em)[\u{E065} \u{E065} \u{E065}])
  ]
}