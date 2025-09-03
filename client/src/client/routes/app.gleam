import client/components/navbar
import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import client/lib/route.{
  StatusTest, About, AdminLogin, CreatePost, CreateSong, Events, FindUs, Index, Membership, NotFound,
  Repertoire, ShowPost, ShowSong,
}
import client/routes/status_test
import client/routes/about
import client/routes/admin
import client/routes/events
import client/routes/find_us
import client/routes/index
import client/routes/membership
import client/routes/repertoire
import gleam/option.{None, Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import shared.{User, Admin}

pub fn app(model: Model) -> Element(Msg) {
  html.div([], [
    // styles.elements(),
    navbar.navbar(model),
    html.div([attribute.styles([#("width", "full"), #("margin", "0 auto")])], [
      case model.route, model.auth_user {
        Index, _ -> index.index(model)
        About, _ -> about.about(model)
        AdminLogin, _ -> admin.admin(model)
        FindUs, _ -> find_us.find_us(model)
        Membership, _ -> membership.membership(model)
        Events, _ -> events.events(model)
        Repertoire, _ -> repertoire.repertoire(model)
        CreateSong, Some(Admin) -> repertoire.create_song(model)
        CreateSong, Some(User) -> error_page("403 Forbidden")
        CreateSong, None -> error_page("401 Unauthorized")
        CreatePost, Some(Admin) -> events.create_post(model)
        CreatePost, Some(User) -> error_page("403 Forbidden")
        CreatePost, None -> error_page("401 Unauthorized")
        StatusTest, Some(Admin) -> status_test.status_test(model)
        StatusTest, _ -> error_page("401 Unauthorized")
        ShowSong(_), Some(_) -> repertoire.show_song(model)
        ShowSong(_), None -> error_page("401 Unauthorized")
        ShowPost(_), _ -> events.show_post(model)
        NotFound, _ -> error_page("404 Not Found")
      },
    ]),
  ])
}

fn error_page(message: String) {
  html.div(
    [
      attribute.styles([
        #("display", "flex"),
        #("flex-direction", "column"),
        #("align-items", "center"),
        #("justify-content", "center"),
        #("min-height", "50vh"),
        #("text-align", "center"),
      ]),
    ],
    [
      html.h1(
        [
          attribute.styles([
            #("font-size", "2.5rem"),
            #("font-weight", "bold"),
            #("margin-bottom", "1rem"),
            #("color", "#333"),
          ]),
        ],
        [element.text(message)],
      ),
      html.p(
        [
          attribute.styles([
            #("font-size", "1.1rem"),
            #("color", "#666"),
            #("margin", "1rem 0"),
          ]),
        ],
        [element.text("Please log in to view this content")],
      ),
      html.a(
        [
          attribute.href("/"),
          attribute.styles([
            #("color", "#0066cc"),
            #("text-decoration", "underline"),
            #("font-size", "1.5rem"),
            #("margin-top", "1rem"),
          ]),
        ],
        [element.text("Return to homepage")],
      ),
    ],
  )
}
