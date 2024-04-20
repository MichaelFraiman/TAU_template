// File that defines problem something
// The style file defines the prob with preapplied arguments
// In the future it should probably be changed to #set

#let problem(
    problem_counter, //counter used to display problem number (ProblemNumber)
    inline_counter, //InlineCounter
    body,
    prob_word: "Problem", //problem name
    prob_punct: ".", //punctuation
    answer: "",
    solution: "",
    note: none,
    display_answer: true, //locate(loc => {answ_disp.at(loc)}),
    answ_word: "Answer",
    display_solution: true, //locate(loc => {sol_disp.at(loc)}),
    qed_symbol: sym.floral,
    sol_word: "Solution",
    les_num: none, //str(les_num.at(loc))
    les_num_symb: "", //les_num_symb.at(loc)
) = {
      {
        set text(
          weight: 900
        )
        problem_counter.step()

        context {
          let l_n = none
          if type(les_num) == state {
            if les_num.get() == none {
              l_n = none
            } else {
              l_n = str(les_num.get())
            }
          } else {
            l_n = les_num
          }

          smallcaps({
            prob_word + [ ]
          if l_n != none {
            l_n + les_num_symb + [.]
          }
          
          problem_counter.display()
          if note != none {
            text(weight: "medium")[ (#note)]
          }
            prob_punct + [ ]
          })
        }
      }
      inline_counter.update(0)
      body

      inline_counter.update(0)
      if answer != "" { // fix
        parbreak()
        text(weight: 900)[#answ_word. ]
        answer
      }
      
      //if display_solution == true { doesn't work???
      inline_counter.update(0)
        if solution != "" {
          parbreak()
          text(weight: 900)[#sol_word. ]
          solution
          if qed_symbol != none {
            h(1fr) + qed_symbol
          }
        }
      //}
    }