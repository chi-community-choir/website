import client/lib/msg.{type Msg}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import shared.{type Post}

pub fn post(post: Post) -> Element(Msg) {
  html.div([], [
    html.a([attribute.href("/events/" <> post.slug)], [
      html.h1([], [element.text(post.title)]),
    ]),
    html.p([], [element.text(post.excerpt)]),
  ])
}
