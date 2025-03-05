import client/components/post
import client/lib/model.{type Model}
import gleam/list
import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/ui/classes

pub fn events(model: Model) {
  html.div([], [
    html.div(
      [attribute.style([#("display", "flex"), #("justify-content", "center")])],
      [html.p([classes.font_alt()], [element.text("Events")])],
    ),
    html.div(
      [
        attribute.style([
          #("display", "flex"),
          #("flex-direction", "columns"),
          #("justify-content", "center"),
        ]),
      ],
      case model.posts {
        [] -> [element.text("no posts found")]
        posts -> list.map(posts, post.post)
      },
    ),
  ])
}
