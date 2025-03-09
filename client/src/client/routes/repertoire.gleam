import client/lib/model.{type Model}
import gleam/list
import gleam/option.{None, Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/ui/classes
import client/lib/msg.{type Msg}
import shared.{type Song}

pub fn repertoire(model: Model) {
  html.div([], [
    html.div(
      [attribute.style([#("display", "flex"), #("justify-content", "center")])],
      [html.p([classes.font_alt()], [element.text("Repertoire")])],
    ),
    html.div(
      [
        attribute.style([
          #("display", "flex"),
          #("flex-direction", "columns"),
          #("justify-content", "center"),
        ]),
      ],
      case model.songs {
        [] -> [element.text("no songs found")]
        songs -> list.map(songs, song)
      },
    ),
  ])
}

pub fn song(song: Song) -> Element(Msg) {
  html.div([], [
    html.a([attribute.href("/events/" <> song.slug)], [
      html.h1([], [element.text(song.title)]),
    ]),
  ])
}

pub fn create_song(_model: Model) {
  todo as "implement song creation"
}

pub fn show_song(model: Model) {
  case model.show_song {
    Some(song) ->
      html.div([], [
        html.h1([], [element.text(song.title)]),
        html.p([], [element.text(song.created_at)]),
      ])
    None ->
      html.div([], [
        html.p([], [element.text("No song found")])
      ])
  }
}
