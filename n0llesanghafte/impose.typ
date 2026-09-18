// impose.typ
// Lays the first two pages of a source PDF side by side on a landscape
// A4 sheet, cropping each page from its full bleed/slug size down to a
// standard A5 trim.
//
// The source PDF filename is passed in via --input source=<name>.pdf
// (see build_cover_pdf.sh), so this file itself never needs to be edited.
//
// Usage (via build_cover_pdf.sh):
//   ./build_cover_pdf.sh nollan-ordinary-cover
//   ./build_cover_pdf.sh nollan-forgotten-cover

#let source = sys.inputs.at("source", default: "nollan-ordinary-cover.pdf")

// Full page size as produced by the cover files (trim + bleed + slug)
#let page-w = 6.80in
#let page-h = 9.24in

// Target trim size (standard A5)
#let trim-w = 148mm
#let trim-h = 210mm

// Symmetric offset from the full page edge to the trim edge
#let dx = (page-w - trim-w) / 2
#let dy = (page-h - trim-h) / 2

#let cropped-page(page-num) = box(width: trim-w, height: trim-h, clip: true)[
  #place(top + left, dx: -dx, dy: -dy)[
    #image(source, page: page-num, width: page-w, height: page-h)
  ]
]

#set page(paper: "a4", flipped: true, margin: 0pt)

#grid(
  columns: (trim-w, trim-w),
  cropped-page(1),
  cropped-page(2),
)