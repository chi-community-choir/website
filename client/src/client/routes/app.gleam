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
          CreateSong, Some(_) -> repertoire.create_song(model)
          CreateSong, None -> element.text("403 forbidden")
          CreatePost, Some(_) -> events.create_post(model)
          CreatePost, None -> element.text("403 forbidden")
          ShowSong(_), _ -> repertoire.show_song(model)
          ShowPost(_), _ -> show_post.show_post(model)
          NotFound, _ -> element.text("404 not found")
          _, _ -> element.text("404 not found")
        },
      ],
    ),
  ])
}
