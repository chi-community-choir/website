import lustre
import gleam/option.{None, Some}
import client/lib/decoder
import client/lib/model.{type Model, Model}
import client/lib/msg.{type Msg}
import client/lib/route
import gleam/dynamic/decode
import gleam/json
import gleam/uri
import lustre/effect.{type Effect}
import lustre_http

@external(javascript, "../ffi.mjs", "set_url")
pub fn set_url(url: String) -> String

@external(javascript, "../ffi.mjs", "render_markdown")
pub fn render_markdown(text: String) -> String

pub fn render_post(content: String) -> Effect(Msg) {
  let msg = content
  |> render_markdown
  |> msg.PostRendered

  effect.from(fn(dispatch) {
    dispatch(msg)
  })
}

pub fn get_auth_user() -> Effect(Msg) {
  let url = "/api/auth/validate"

  lustre_http.get(
    url,
    lustre_http.expect_json(decoder.auth_user_decoder(), msg.AuthUserReceived),
  )
}

pub fn get_songs() -> Effect(Msg) {
  let url = "/api/songs"

  let response_decoder = {
    use songs <- decode.field("songs", decode.list(decoder.song_decoder()))
    decode.success(msg.GetSongsResponse(songs))
  }

  lustre_http.get(
    url,
    lustre_http.expect_json(response_decoder, msg.SongsReceived),
  )
}

pub fn get_posts() -> Effect(Msg) {
  let url = "/api/posts"

  let response_decoder = {
    use posts <- decode.field("posts", decode.list(decoder.post_decoder()))
    decode.success(msg.GetPostsResponse(posts))
  }

  lustre_http.get(
    url,
    lustre_http.expect_json(response_decoder, msg.PostsReceived),
  )
}

pub fn get_show_song() -> Effect(Msg) {
  let url = "/api/songs/" <> get_song_slug()

  lustre_http.get(
    url,
    lustre_http.expect_json(decoder.song_decoder(), msg.ShowSongReceived),
  )
}

pub fn get_show_post() -> Effect(Msg) {
  let url = "/api/posts/" <> get_post_slug()

  lustre_http.get(
    url,
    lustre_http.expect_json(decoder.post_decoder(), msg.ShowPostReceived),
  )
}

fn get_song_slug() -> String {
  let uri = case route.do_get_route() |> uri.parse {
    Ok(uri) -> uri
    _ -> panic as "Invalid uri"
  }

  case uri.path |> uri.path_segments {
    ["repertoire", song_slug] -> song_slug
    _ -> ""
  }
}

fn get_post_slug() -> String {
  let uri = case route.do_get_route() |> uri.parse {
    Ok(uri) -> uri
    _ -> panic as "Invalid uri"
  }

  case uri.path |> uri.path_segments {
    ["events", post_slug] -> post_slug
    _ -> ""
  }
}

pub fn create_song(model: Model) {
  lustre_http.post(
    "/api/songs",
    json.object([
      #("title", json.string(model.create_song_title)),
      #("href", json.string(model.create_song_href)),
    ]),
    lustre_http.expect_json(
      msg.message_error_decoder(),
      msg.CreateSongResponded,
    ),
  )
}
