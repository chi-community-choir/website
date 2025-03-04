import lustre/attribute.{style}

/// Default page styling, for uniformity
pub fn page_default() {
  style([
    #("display", "flex"),
    #("flex-direction", "column"),
    #("min-height", "100vh"),
    #("padding", "0"),
    #("margin", "0"),
  ])
}
/// Container with two items side by side, wrapping on small screens.
pub fn aside_wrap() {
  style([
    #("display", "flex"),
    #("flex-flow", "row wrap"),
    #("align-items", "center"),
    #("justify-content", "center"),
    #("gap", "1rem 2rem"),
    #("padding", "2rem 1rem"),
    #("max-width", "100%"),
    #("margin", "0 auto"),
  ])
}

pub fn styled_link() {
  style([
    #("color", "#2c52FF"),
    #("text-decoration", "underline"),
    #("font-weight", "600"),
  ])
}

/// Limits the size of an image by its height
pub fn img_md() {
  style([
    #("max-width", "100%"),
    #("height", "auto"),
    #("max-height", "400px"),
    #("object-fit", "contain"),
  ])
}

pub fn img_full() {
  style([
    #("max-width", "100%"),
    #("height", "auto"),
    #("object-fit", "contain"),
  ])
}
