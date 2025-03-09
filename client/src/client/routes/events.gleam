import client/styles
import client/components/post
import client/lib/model.{type Model}
import gleam/list
import gleam/option.{Some}
import lustre/attribute
import lustre/element
import lustre/element/html
import lustre/ui
import lustre/ui/button
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
      [
        // search bar, admin "create post" button
      ]
      |> list.append(
        case model.posts {
          [] -> [element.text("no posts found")]
          posts -> {
            // list.map(posts, post.post)
            use post <- list.map(posts)
            html.div([
              styles.aside_wrap()
            ], [
              html.div([], [
                post.post(post),
              ]),
              html.div([], case model.auth_user {
                Some(user) if user.is_admin -> [
                  ui.button(
                    [
                      button.solid(), 
                      // event.on_click(msg.DeletePost(post))
                    ],
                    [element.text("DELETE")],
                  ),
                ]
                _ -> []
              }
              )
            ])
          }
        },
      ),
    ),
  ])
}

pub fn create_post(model: Model) {
  todo as "create_post"
}
