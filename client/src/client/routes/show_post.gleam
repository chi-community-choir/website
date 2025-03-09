import lustre/element
import lustre/element/html
import client/lib/model.{type Model}
import shared.{type Post}

pub fn show_post(_model: Model, post: Post) {
  html.div([], [
    html.h1([], [element.text(post.title)])
  ])
}
