import gleam/option.{None, Some}
import lustre/element
import lustre/element/html
import client/lib/model.{type Model}

pub fn show_post(model: Model) {
  case model.show_post {
    Some(post) ->
      html.div([], [
        html.h1([], [element.text(post.title)])
      ])
    None ->
      html.div([], [
        html.p([], [element.text("No post found")])
      ])
  }
}
