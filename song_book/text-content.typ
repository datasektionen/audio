//! Contains a function for parsing the format used by the content fields for
//! songs in 'songs.json', which support line breaks, basic HTML elements, and
//! some character aliases.

/// Parses a string containing <i> and <b> HTML tags into content. Any other
/// tags is an error.
///
/// - string (str):
/// -> content
#let parse-basic-html(string) = {
  // To parse the HTML we just pretend that it's valid XML, and use the built in
  // XML parser (surely this won't cause issues). We need to wrap the document
  // in any arbitrary root element for it to be valid XML.
  // We also replace the `&shy;` entity manually since Typst's XML parser
  // doesn't support defining entities.
  string = string.replace("&shy;", [-?].text)
  let xml-document = ("<root>" + string + "</root>")

  let document = xml(bytes(xml-document))

  /// Convert all valid (based on the outer functions notion) tags in a XML
  /// element into Typst content. Allows list elements on the top level
  ///
  /// Note: An "XML element" is either a string or a dictionary (following the
  /// format of the `xml` function of course).
  ///
  /// -> content
  let convert-tags(element) = {
    if type(element) == str {
      return element
    }

    let tag-element-functions = (
      "p": par,
      "b": strong,
      "i": text.with(style: "italic"),
    )

    let element-function = if element.tag in tag-element-functions {
      tag-element-functions.at(element.tag)
    } else {
      panic("unsupported HTML tag <" + str(element.tag) + ">")
    }

    element-function(
      element.children.map(child => { convert-tags(child) }).join(),
    )
  }

  let elements = document.first().children
  for line-element in elements {
    convert-tags(line-element)
  }
}

/// Parses a content field of a song from 'songs.json' into content. This format
/// supports line breaks and <i> and <b> HTML tags. Any other HTML tags is an
/// error.
/// `--` and `---` are converted to en and em dashes respectively.
///
/// - string (str):
/// - add-after-nth-par (none|array): If set, should be an array containing an
///   index and content. That content will be inserted after the paragraph with
///   that index (zero-indexed).
/// -> content
#let parse-text-content(string, add-after-nth-par: none) = {
  // The website use more than two consecutive line breaks at some places to
  // signal that the song is split across pages in the physical book. The book
  // PDF of course support pagebreaks, so we collapse these into
  // a single paragraph break.
  let paragraph-strings = string.split(regex(`\r?\n\r?\n(\r?\n)*`.text))

  for (index, string) in paragraph-strings.enumerate() {
    show regex("[^-]--[^-]"): it => {
      let ends = it.text.split("--")
      ends.first()
      [--]
      ends.last()
    }
    show regex("[^-]---[^-]"): it => {
      let ends = it.text.split("---")
      ends.first()
      [---]
      ends.last()
    }
    show "\"": sym.quote.r.double
    show "'": sym.quote.r.single

    block(breakable: false, par(parse-basic-html(string)))
    if (add-after-nth-par != none and index == add-after-nth-par.at(0)) {
      add-after-nth-par.at(1)
    }
  }
}
