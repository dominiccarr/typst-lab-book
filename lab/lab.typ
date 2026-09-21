#let pt-colour = rgb("#DCEEFF")
#let paper-colour = rgb("#E8F5E9")
#let ws-colour = rgb("#F7E9DF")
#let other-colour = rgb("#FFCDD2")
#let gold-fill = rgb("#FFF4CC")

#let show-solutions = state("labs-show-solutions", true)
#let dom-hints = state("labs-dom-hints", true)
#let delivery-notes = state("labs-delivery-notes", true)
#let main-type = state("Packet Tracer", true)
#let lab-headers = state("Lab Headers", true)
#let lab-counter = counter("labs-lab")

#lab-counter.update(100)

// ------------------------------------------------------------
// Public components
// ------------------------------------------------------------

#let solution(
  body,
  fill: gold-fill,
) = box(
  width: 100%,
  inset: 10pt,
  fill: fill,
  stroke: 1pt,
  radius: 4pt,
)[
  #align(center)[
    #text(size: 3em, weight: "bold")[Solution]
  ]

  #v(0.5em)

  #body
]


#let sol-wrap(body) = context {
  if show-solutions.get() {
    solution(body)
  }
}


#let goal(
  body,
  fill: gold-fill,
) = box(
  width: 100%,
  inset: 10pt,
  fill: fill,
  stroke: 1pt,
  radius: 4pt,
)[
  #heading(
    level: 2,
    numbering: none,
  )[Lab Goals]

  #body
]


#let important-note(
  body,
) = box(
  width: 100%,
  inset: 10pt,
  fill: rgb("#FDE2E2"),
  stroke: 1pt + rgb("#C62828"),
  radius: 4pt,
)[
  #text(
    size: 1.5em,
    weight: "bold",
  )[Important Note]

  #v(0.5em)

  #body
]


#let mini-solution(
  body,
) = box(
  inset: (x: 6pt, y: 3pt),
  fill: rgb("#FFF4CC"),
  stroke: 0.5pt + rgb("#D4AF37"),
  radius: 3pt,
)[
  #text(weight: "bold")[Solution: ]
  #body
]


#let mini-sol-wrap(
  body,
) = context {
  if show-solutions.get() {
    mini-solution(body)
  }
}


#let dom-note-display(
  body,
) = box(
  width: 100%,
  inset: 10pt,
  fill: rgb("#FDE2E2"),
  stroke: 1pt + rgb("#C62828"),
  radius: 4pt,
)[
  #text()[The file for this is *#body*]
]


#let dom-note(body) = context {
  if dom-hints.get() {
    dom-note-display(body)
  }
}

#let delivery-note-display(
  body,
) = box(
  width: 100%,
  inset: 10pt,
  fill: rgb("#E8F5E9"),
  stroke: 1pt + rgb("#E8F5E9").darken(50%),
  radius: 4pt,
)[
  #text(
    size: 1.5em,
    weight: "bold",
  )[Delivery Note]

  #v(0.3em)

  This was done in class #body
]

#let delivery-note(body) = context {
  if delivery-notes.get() {
    delivery-note-display(body)
  }
}




// ------------------------------------------------------------
// Section counter
// ------------------------------------------------------------

#let section-counter = counter("doc-section")

#let section(x) = {
  section-counter.step()

  context {
    if section-counter.get().first() <= lab-counter.get().first() {
      x
    }
  }
}


// ------------------------------------------------------------
// Main labs function
// ------------------------------------------------------------

#let labs(
  title: "Sommit",
  author: "Gerry Agnew",
  paper-size: "a4",

  l1-headings: 1.7em,
  l2-headings: 1.5em,
  l3-headings: 1em,
  cover-heading: 5em,

  show-solutions: true,
  dom-hints: true,
  delivery-notes: true,

  lab-counter: 100,

  body,
) = [

  // ----------------------------------------------------------
  // Document setup
  // ----------------------------------------------------------

  #set document(
    title: title,
    author: author,
  )

  #set text(
    font: "New Computer Modern",
  )

  #show raw: set text(
    font: "New Computer Modern Mono",
  )


  // ----------------------------------------------------------
  // Inline packet-tracer marker
  // ----------------------------------------------------------

  #show regex("\"[^\"]*pk(t|a)\""): it => box(
    fill: other-colour,
    stroke: 0.5pt,
    radius: 2pt,
    inset: (x: 4pt, y: 3pt),
  )[
    #it
  ]


  // ----------------------------------------------------------
  // Code blocks
  // ----------------------------------------------------------

  #show raw.where(block: true): it => block(
    fill: luma(245),
    spacing: 1.2em,
    inset: 10pt,
    stroke: 0.5pt,
    radius: 4pt,
    width: 100%,
  )[
    #it
  ]


  #show raw.where(block: false): it => box(
    fill: luma(245),
    stroke: 0.5pt,
    radius: 2pt,
    inset: (x: 4pt, y: 3pt),
  )[
    #it
  ]


  // ----------------------------------------------------------
  // Figures and lists
  // ----------------------------------------------------------

  #show figure: it => {
    it
    v(0.5em)
  }


  #show list: it => {
    v(0.5em)
    it
  }


  // ----------------------------------------------------------
  // Page setup
  // ----------------------------------------------------------

  #set page(
    paper: paper-size,

    margin: (
      bottom: 1.5cm,
      top: 1.5cm,
      left: 1.5cm,
      right: 1.5cm,
    ),

    footer: figure(
      image("images/atu.jpg", height: 90%),
      numbering: none,
    ),

    background: {
      place(
        top + left,
        dx: 1cm,
        dy: 1cm,
        rect(
          width: 100% - 2cm,
          height: 100% - 2cm,
          stroke: 1pt,
        ),
      )
    },
  )


  // ----------------------------------------------------------
  // Paragraph setup
  // ----------------------------------------------------------

  #set par(
    spacing: 0.7em,
    leading: 0.5em,
    first-line-indent: 0em,
    justify: true,
  )


  #set heading(
    numbering: "1.1.1",
    supplement: "Lab",
  )


  // ----------------------------------------------------------
  // Level 1 headings
  // ----------------------------------------------------------

  #show heading.where(level: 1): it => {
    pagebreak()

    let d = it.supplement

    let fill = if d == [EP] {
      other-colour
    } else if d == [PE] {
      paper-colour
    } else if d == [WS] {
      ws-colour
    } else {
      pt-colour
    }

    let types = if d == [EP] {
      [Packet Tracer]
    } else if d == [PE] {
      [Paper Exercise]
    } else if d == [WS] {
      [Wireshark]
    } else {
      [Packet Tracer]
    }

    let pre = if it.numbering != none {
      [Lab #counter(heading).display(it.numbering) -]
    }

    v(1em)

    block(
      width: 100%,
      inset: 10pt,
      fill: fill,
      stroke: 1pt + fill.darken(50%),
      radius: 4pt,
    )[

      #if lab-headers.get() {
        text(
          l3-headings,
          weight: 700,
        )[#types]

      v(0.2em)    
      }


      #text(
        l1-headings,
        weight: 700,
      )[
        #pre #it.body
      ]
    ]

    v(0.5em)
  }


  // ----------------------------------------------------------
  // Level 2 headings
  // ----------------------------------------------------------

  #show heading.where(level: 2): it => {
    v(0.2em)

    text(
      size: l2-headings,
      weight: "bold",
      style: "normal",
    )[
      #it
    ]

    v(0.2em)
  }


  // ----------------------------------------------------------
  // Level 3 headings
  // ----------------------------------------------------------

  #show heading.where(level: 3): it => {
    v(0.2em)

    text(
      size: l3-headings,
      weight: "bold",
      style: "normal",
    )[
      #it
    ]

    v(0.2em)
  }


  // ----------------------------------------------------------
  // Cover page
  // ----------------------------------------------------------

  #page(
    footer: none,

    align(
      center + horizon,
    )[
      #text(
        cover-heading,
        weight: "bold",
      )[
        #title
      ]

      #v(2.5em)

      #text(
        2.5em,
        author,
      )
    ],
  )


  // ----------------------------------------------------------
  // Table of contents
  // ----------------------------------------------------------

  #show outline.entry: it => link(
    it.element.location(),

    it.indented(
      if it.element.at(
        "label",
        default: none,
      ) == <commandref> {
        none
      } else if it.prefix() != none {
        [Lab #it.prefix() --]
      } else {
        none
      },

      it.inner(),
    ),
  )


  #show outline.entry: it => {
    let heading = it.element

    let fill-color = if heading.supplement == [WS] {
      ws-colour
    } else if heading.supplement == [PE] {
      paper-colour
    } else if heading.supplement == [EP] {
      other-colour
    } else {
      pt-colour
    }

    block(
      fill: fill-color.lighten(50%),
      inset: (x: 5pt, y: 3pt),
      radius: 3pt,
      stroke: 0.3pt + fill-color.darken(50%),
    )[
      #it
    ]
  }


  #show outline: set heading(
    numbering: none,
  )


  #show outline: it => {
    show heading: it => {
      block(
        radius: 5pt,
        inset: 10pt,
        width: 100%,
      )[
        #text(
          size: l1-headings,
          weight: 700,
        )[
          #it.body
        ]
      ]
    }

    it
  }


  #outline(
    title: [Table of Contents],
    depth: 1,
  )


  // ----------------------------------------------------------
  // Document body
  // ----------------------------------------------------------

  #body
]
