import client/routes/show_post
import client/components/navbar
import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import client/lib/route.{About, CreateSong, FindUs, Index, Membership, NotFound, ShowSong, Repertoire, Events, CreatePost, ShowPost}
import client/routes/about
import client/routes/find_us
import client/routes/index
import client/routes/membership
import client/routes/events
import client/routes/repertoire
import gleam/option.{Some, None}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/ui/styles
import shared.{AuthUser}

pub fn app(model: Model) -> Element(Msg) {
  html.div([], [
    styles.elements(),
    navbar.navbar(model),
    // Routing
    html.div(
      [
        attribute.style([
          #("width", "full"),
          #("margin", "0 auto"),
        ]),
      ],
      [
        case model.route, model.auth_user {
          Index, _ -> index.index(model)
          About, _ -> about.about(model)
          FindUs, _ -> find_us.find_us(model)
          Membership, _ -> membership.membership(model)
          Events, _ -> events.events(model)
          Repertoire, _ -> repertoire.repertoire(model)
          CreateSong, Some(AuthUser(True)) -> repertoire.create_song(model)
          CreateSong, Some(AuthUser(False)) -> element.text("403 Forbidden")
          CreateSong, None -> element.text("401 Unauthorized")
          CreatePost, Some(AuthUser(True)) -> events.create_post(model)
          CreatePost, Some(AuthUser(False)) -> element.text("403 Forbidden")
          CreatePost, None -> element.text("401 Unauthorized")
          ShowSong(_), Some(_) -> repertoire.show_song(model)
          ShowSong(_), None -> element.text("401 Unauthorized")
          ShowPost(_), Some(_) -> show_post.show_post(model)
          ShowPost(_), None -> element.text("401 Unauthorized")
          NotFound, _ -> element.text("404 Not Found")
          _, _ -> element.text("400 Bad Request")
        },
      ],
    ),
  ])
}
