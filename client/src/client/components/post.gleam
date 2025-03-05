import client/lib/msg.{type Msg}
import lustre/element.{type Element}
import lustre/element/html
import shared.{type Post}

pub fn post(post: Post) -> Element(Msg) {
  html.div([], [html.p([], [element.text(post.title)])])
}
