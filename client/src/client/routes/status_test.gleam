import client/lib/msg
import lustre/event
import gleam/int
import client/lib/model.{type Model}
import client/styles
import lustre/attribute.{class, styles}
import lustre/element.{text}
import lustre/element/html.{div, h1, section}

pub fn status_test(model: Model) {
  div(
    [
      styles.page_default(),
      styles([
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
        div([], [html.button([event.on_click(msg.TestIncrement)], [text("inc")])]),
      ]),
    ],
  )
}
