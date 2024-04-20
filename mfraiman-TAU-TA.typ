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
#let g_les_num = state("LessonNumber", none)
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
#let glob_font_tt = state("FontMono", "Pt Mono")

//data loading
#let load_doc_params(
  name,
  class,
  activity_type
  ) = {
  //let full = name + ".json" 
  let full = name + ".yaml"
  //let info_file = json(full)
  let info_file = yaml(full)
  let date_en = str(info_file.at(class).at(activity_type).date.en)
  let date_he = str(info_file.at(class).at(activity_type).date.he)
  let date = ""
  if date_he == "" {
    date = date_en
  } else {
    //date = date_en + " ‎" + date_he
    date = date_he + " ‎" + date_en
  }
  let link_to_cc = none
  if "link" in info_file.at(class).at(activity_type) {
    link_to_cc = info_file.at(class).at(activity_type).link
  }
  let params = (
    // general info for the course
    // chapter
    chapter_en: info_file.general.chapter.en,
    chapter_he: info_file.general.chapter.he,
    chapter_ar: info_file.general.chapter.ar,
    chapter: "⁦" + info_file.general.chapter.en + "⁦ " +  info_file.general.chapter.he + "‎ " + info_file.general.chapter.ar + "‎",
    // part
    part_en: info_file.general.part.en,
    part_he: info_file.general.part.he,
    part_ar: info_file.general.part.ar,
    part: "⁦" + info_file.general.part.en + "⁦ " + info_file.general.part.he + "‎ " + info_file.general.part.ar + "‎",
    // course
    course_period: info_file.general.course.period,
    //
    display_sols: info_file.general.activity_types.at(activity_type),
    paper: info_file.general.activity_types.at(activity_type).paper,
    activity_name: info_file.general.activity_types.at(activity_type).activity_name,
    // specific for the class
    num: info_file.at(class).num,
    name: info_file.at(class).name,
    //name_header: info_file.at(class).name_header,
    date_en: date_en,
    date_he: date_he,
    date: date,
    num_symb: info_file.at(class).at(activity_type).num_symb,
    // footer info
    lecturer_name_en: info_file.general.lecturer.name.en,
    lecturer_name_he: info_file.general.lecturer.name.he,
    lecturer_email: info_file.general.lecturer.email,
    lecturer_position_en: info_file.general.lecturer.position.en,
    lecturer_position_he: info_file.general.lecturer.position.he,
    teacher_position_en: info_file.general.teacher.position.en,
    teacher_position_he: info_file.general.teacher.position.he,
    teacher_name: info_file.general.teacher.name,
    teacher_email: info_file.general.teacher.email,
    course_period_word_en: info_file.general.course.period.word.en,
    course_period_word_he: info_file.general.course.period.word.he,
    course_period_en: info_file.general.course.period.dates.en,
    course_period_he: info_file.general.course.period.dates.he,
    reception_name_en: info_file.general.teacher.reception.name.en,
    reception_name_he: info_file.general.teacher.reception.name.he,
    reception_time_en: info_file.general.teacher.reception.time.en,
    reception_time_he: info_file.general.teacher.reception.time.he,
    pdf_info: info_file.general.teacher.pdf_info,
    link_word_en: info_file.general.link.word.en,
    link_word_he: info_file.general.link.word.he,
    link_to_cc: link_to_cc
  )
  params
}

// lists
#let enum_l = li.enum_l
#let enum_big = li.enum_big.with(spacing: glob_b)
#let enum_cond = li.enum_cond
#let rr = li.rr.with(InlineCounter)
#let ur = li.ur
#let list_bull = li.list_bull.with(spacing: glob_b * 0.5)
#let enum_col = li.enum_col.with(InlineCounter)

//Problem setup
// needs a fix for g_sol_disp
#let prob = problem.problem.with(
    ProblemNumber, //counter used to display problem number (ProblemNumber)
    InlineCounter, //InlineCounter
    prob_word: "Problem",
    prob_punct: ".",
    display_answer: context g_answ_disp.get(),
    display_solution: context g_sol_disp.get(),
    les_num: g_les_num,
    les_num_symb: context g_les_num_symb.get(),
)

#let ex = problem.problem.with(
    ProblemNumber, //counter used to display problem number (ProblemNumber)
    InlineCounter, //InlineCounter
    prob_word: "Example",
    prob_punct: ".",
    display_answer: context g_answ_disp.get(),
    display_solution: context g_sol_disp.get(),
    les_num: context g_les_num.get(),
    les_num_symb: context g_les_num_symb.get(),
)

#let theorem = th.theorem.with(
  TheoremCounter,
  name: "Theorem",
  les_num: context g_les_num.get(),
  les_num_symb: context g_les_num_symb.get(),
  body_style: "italic",
  numbered: true
)

#let definition = th.theorem.with(
  TheoremCounter,
  name: "Definition",
  les_num: context g_les_num.get(),
  les_num_symb: context g_les_num_symb.get(),
  body_style: "normal",
  numbered: true
)

#let remark = th.theorem.with(
  TheoremCounter,
  name: "Remark",
  les_num: context g_les_num.get(),
  les_num_symb: context g_les_num_symb.get(),
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

  let params = load_doc_params(info_file, class_id, activity)

  let paper = params.paper
  let num = params.num
  let num_symb = params.num_symb
  let date = params.date
  let disp = params.display_sols
  let name = params.name
  let name_header = params.name + ". " + params.activity_name
  let chapter = params.chapter
  let part = params.part

  let w_foot_b = "regular"
  let w_foot_l = "extralight"
  let w_foot_th = "thin"
  let w_foot_eb = "bold"

  let w_head_b = "medium"
  let w_head_l = "light"

  let n_top_above = 1.5 //number of lines above the header
  let n_top_below = 1 // same, but below the header
  let header_font_size = 0.9em

  let n_bottom_above = 1
  let n_bottom_below = 1
  let footer_font_size = 0.75em

  let n_header_height = 2
  let n_footer_height = 4

  //how many lines fit in the paper (REQUIRES A FIX)
  let baselines_num = calc.floor(297mm / glob_baselineskip)
  let paper_excess = 297mm - baselines_num * glob_baselineskip

  let page_num_display(
    page: 0,
    total: 0,
    lang: "en",
    weight_page: "bold",
    weight_words: "light"
  ) = {
    if lang == "he" {
      text(weight: weight_words)[עמוד]
      [ ]
      str(page)
      text(weight: weight_words)[ מתוך ]
      str(total)
    } else {
      text(weight: weight_words)[Page ]
      str(page)
      text(weight: weight_words)[ of ]
      str(total)  
    }
  }

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
      header: context {
        rect(
          inset: 0pt,
          outset: 0pt,
          height: 2 * glob_baselineskip,
          width: 100%,
          stroke: 0mm
        )[#{
          set text(
            stretch: 50%,
            font: font_header,
            size: header_font_size,
            weight: w_head_b,
            historical-ligatures: false,
            discretionary-ligatures: false
          )
          set par(leading: glob_rel_leading*0.5)
          if text.lang == "he" {
              params.chapter_he + " " + params.chapter_ar + " " + params.chapter_en
              h(1fr)
              "‏‎" + params.date_en + "‏ " + params.date_he
              linebreak()
            text(
              weight: w_head_l
            )[#{
              params.part_he + " " + params.part_ar + " " + params.part_en
              h(1fr)
              if num != none {
                "‏‎" + str(num) + str(num_symb) + [. ]
                name_header
              } else {
                name_header
              }
              //part + h(1fr) + str(num) + str(num_symb) + [. ] + name_header
            }]
          } else {
              chapter + h(1fr) + date
              linebreak()
            text(
              weight: w_head_l
            )[#{
              if num != none {
                part + h(1fr) + str(num) + str(num_symb) + [. ] + name_header
              } else {
                part + h(1fr) + name_header
              }
            }]          
          }
        }]
        v(glob_b - glob_baselineskip + n_top_below * glob_baselineskip)
      },
      footer: {
        v(n_bottom_above * glob_baselineskip)
        rect(
          inset: 0pt,
          outset: 0pt,
          height: 3 * glob_baselineskip,
          width: 100%,
          stroke: 0.0mm
        )[#{
          v(glob_b - glob_baselineskip)
          set text(
            stretch: 50%,
            font: font_footer,
            size: footer_font_size,
            weight: w_foot_b,
            historical-ligatures: false,
            discretionary-ligatures: false,
            dir: ltr
          )
          set par(leading: glob_rel_leading*0.45)
            params.lecturer_position_en
            [: ]
            text(weight: w_foot_l)[#params.lecturer_name_en ]
            link("mailto:" + params.lecturer_email)[
              #text(font: font_tt, weight: w_foot_l)[#params.lecturer_email]
            ]
            h(1fr)
            text(weight: w_foot_l)[⁦#params.lecturer_name_he⁦ ]
            [‫] + params.lecturer_position_he + [: ]
          linebreak()
            params.teacher_position_en
            [: ]
            text(weight: w_foot_l)[#params.teacher_name.en ]
            link("mailto:" + params.teacher_email)[
              #text(font: font_tt, weight: w_foot_l)[#params.teacher_email]
            ]
            h(1fr)
            text(weight: w_foot_l)[⁦#params.teacher_name.he⁦ ]
            [‫] + params.teacher_position_he + [: ]
          linebreak()
            params.reception_name_en + [: ]
            text(weight: w_foot_l)[#params.reception_time_en]
            h(1fr)
            text(weight: w_foot_l)[⁦#params.reception_time_he⁦]
            [⁧] + params.reception_name_he + [: ⁦]
          linebreak()
            params.course_period_word_en + [: ]
            text(weight: w_foot_l)[#params.course_period_en]
            h(1fr)
            text(weight: w_foot_l)[⁦#params.course_period_he⁦]
            [⁧] + params.course_period_word_he + [: ⁦]
          if params.link_to_cc != none {
            linebreak()
            params.link_word_en + [: ]
            link("https://" + params.link_to_cc)[
              #text(font: font_tt, weight: w_foot_l)[#params.link_to_cc]
            ]
            h(1fr)
            text(weight: w_foot_l)[⁦#sym.arrow.l.filled⁦]
            [⁧] + params.link_word_he + [: ⁦]
          }
          linebreak()
          text(
            weight: w_foot_th,
            font: font_sf,
            stretch: 50%,
            size: 0.8em
          )[#params.pdf_info]
          h(1fr)
          text(
            stretch: 100%,
            weight: w_foot_eb
          )[#{
            context {
              page_num_display(
                page: counter(page).display(),
                total: counter(page).final().first(),
                lang: lang,
                weight_page: w_foot_eb,
                weight_words: w_foot_l
              )
            }
          }]
        }]
        v(n_bottom_below * glob_baselineskip)
      },
      footer-descent: 0%
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

  show heading.where(
    level: 1
  ): it => block(
      width: 100%,
      above: glob_b,
      below: glob_b,
    )[#{
    set text(
      22pt,
      weight: 900,
      font: font_sf,
      stretch: 100%
    )
    context {
      if g_les_num.get() != none {
        str(g_les_num.get())
        str(g_les_num_symb.get())
        [. ]
      }
    }
    smallcaps(it.body)
  }]

  show heading.where(
    level: 2
  ): { it => block(
      width: 100%,
      below: glob_b,
      above: glob_b
    )[#{
    set text(
      16pt,
      weight: 700,
      font: font_sf
    )
    [§ ]
    smallcaps(it.body)
  }] }

  show math.equation: set text(
      font: font_math,
      size: 1.05em
  )

  //show "LHS": smallcaps

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

  set math.equation(
    numbering: {
      (..nums) => {
        set text(
          weight: "light",
          font: font_rm,
          style: "normal",
          stretch: 100%,
          ligatures: false,
        )
        "("
        context{
          if g_les_num.get() != none {
            str(g_les_num.get())
            g_les_num_symb.get()
            [.]
          }
        }
        {
          set text(
            weight: "regular"
          )
          numbering("א", nums.pos().first())
        }
        ")"
      }
    }
  )

  set figure(
    numbering: {
      (..nums) => {
        set text(
          weight: "regular",
          font: font_rm,
          style: "normal",
          stretch: 100%,
          ligatures: false,
        )
        context{
          if g_les_num.get() != none {
            str(g_les_num.get())
            g_les_num_symb.get()
            [.]
          }
        }
        numbering("1", nums.pos().first())
      }
    }
  )

  show figure.caption: set text(size: 0.7em)

  //show "ODE": smallcaps[ode]
  //show regex("DE"): smallcaps[de]
  //show "LHS": smallcaps[lhs]
  //show "RHS": smallcaps[rhs]

  g_sol_disp.update(disp)
  g_les_num.update(num)
  g_les_num_symb.update(num_symb)

  glob_font_rm.update(font_rm)
  glob_font_sf.update(font_sf)
  glob_font_tt.update(font_tt)

  doc

}

 #let important(title, body) = {
  context {
    box.slantedColorbox(
      title: title,
      col_back: rgb(230, 232, 244),
      col_stroke: rgb(9, 31, 146),//navy,
      col_title: rgb(9, 31, 146),
      col_text_title: white,
      col_text_body: black,
      font_body: glob_font_rm.get(),
      font_title: glob_font_sf.get(),
      font_emoji: "Noto Emoji",
      emoji: emoji.finger.r,
      radius: 0pt,
      width: auto,
      body
    )
  }
}

 #let attention(title, body) = {
  context {
    box.slantedColorbox(
      title: title,
      col_back: rgb(255,230,234),
      col_stroke: rgb(153,0,26),
      col_title: rgb(153,0,26),
      col_text_title: white,
      col_text_body: black,
      font_body: glob_font_rm.get(),
      font_title: glob_font_sf.get(),
      font_emoji: "Noto Emoji",
      emoji: emoji.siren,
      radius: 0pt,
      width: auto,
      body
    )
  }
}

#let footnote_dict(
  term,
  def,
  // alternative spelling
  alt: none,
  // part of speech
  pos: none,
  // note such as obsolete, slang etc
  note: none,
  // pronunciation
  pro: none
) = {
  footnote({
    context {
      text(font: glob_font_sf.get(), weight: 700)[#smallcaps(term)]
      if alt != none {
        text(font: glob_font_sf.get(), style: "italic", weight: 300, size: 0.9em)[ or]
        text(font: glob_font_sf.get(), weight: 700)[ #smallcaps(alt)]     
      }
      if pro != none { text(font: "Doulos SIL", fallback: false)[ /#sym.space.thin#pro#sym.space.thin/] }
      if pos != none { text(font: glob_font_sf.get(), style: "italic", weight: 300, size: 0.9em)[ #pos] }
      if note != none { text(font: glob_font_sf.get(), style: "italic", weight: 300, size: 0.9em)[ (#note)] }
      [ ] + def
    }
  })
}


//logical break
#let br_log() = {
  block(
    width: 100%,
    height: glob_baselineskip,
    //spacing: - 0.5 * glob_baselineskip
  )[
    #align(
      center + horizon,
      text(size: 2em)[#sym.ast #sym.ast #sym.ast])
  ]
}

#let class_optional(body) = {
  set text(size: 0.85em)
  br_log()
  body
  br_log()
}

#let acr(text) = {smallcaps[#text]}