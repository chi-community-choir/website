import client/lib/msg
import lustre/event
import lustre/ui
import gleam/int
import client/lib/model.{type Model}
import client/styles
import lustre/attribute.{alt, class, src, style}
import lustre/element.{text}
import lustre/element/html.{a, br, div, h1, h2, img, p, section}

pub fn status_test(model: Model) {
  div(
    [
      styles.page_default(),
      style([
        #("align-items", "center"),
        #("font-size", "18px"),
        #("line-height", "1.8"),
      ]),
    ],
    [
      section([class("title")], [
        div([], [h1([], [text("Status Test")])])
      ]),
      section([class("counter")], [
        div([], [text(model.test_model.counter |> int.to_string)]),
        div([], [ui.button([event.on_click(msg.TestIncrement)], [text("inc")])]),
      ]),
    ],
  )
}
