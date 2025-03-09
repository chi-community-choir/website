import client
import client/lib/model.{Model}
import client/lib/route.{
  About, CreatePost, CreateSong, Events, FindUs, Index, Membership, NotFound,
  Repertoire, ShowPost, ShowSong,
}
import cors_builder as cors
import gleam/erlang/process.{type Subject}
import gleam/http
import gleam/option.{None, Some}
import lustre/element
import server/db/user_session
import server/lib/encoder
import server/response
import server/routes/auth/login
import server/routes/auth/logout
import server/routes/auth/validate
import server/routes/cache/session_cache.{type CacheMessage}
import server/routes/post
import server/routes/posts
import server/routes/song
import server/routes/songs
import server/scaffold
import server/web
import shared.{AuthUser}
import wisp.{type Request, type Response}

pub fn handle_request(
  req: Request,
  cache_subject: Subject(CacheMessage),
) -> Response {
  use req <- web.middleware(req)
  use req <- cors.wisp_middleware(
    req,
    cors.new()
      |> cors.allow_origin("http://localhost:1234")
      |> cors.allow_method(http.Get)
      |> cors.allow_method(http.Post)
      |> cors.allow_header("Content-Type"),
  )

  case wisp.path_segments(req) {
    ["api", ..] -> api_routes(req, wisp.path_segments(req), cache_subject)
    ps -> page_routes(req, ps, cache_subject)
  }
}

fn api_routes(
  req: Request,
  route_segments: List(String),
  cache_subject: Subject(CacheMessage),
) -> Response {
  case route_segments {
    ["api", "posts"] ->
      case user_session.get_user_from_session(req, cache_subject) {
        Ok(_) -> posts.posts(req)
        Error(_) -> response.error("Unauthorized - please log in")
      }
    ["api", "posts", post_slug] -> {
      case user_session.get_user_from_session(req, cache_subject) {
        Ok(_) -> post.post(req, post_slug)
        Error(_) -> response.error("Unauthorized - please log in")
      }
    }
    ["api", "songs"] ->
      case user_session.get_user_from_session(req, cache_subject) {
        Ok(_) -> songs.songs(req)
        Error(_) -> response.error("Unauthorized - please log in")
      }
    ["api", "songs", song_slug] -> {
      case user_session.get_user_from_session(req, cache_subject) {
        Ok(_) -> song.song(req, song_slug)
        Error(_) -> response.error("Unauthorized - please log in")
      }
    }
    ["api", "auth", "login"] -> login.login(req)
    ["api", "auth", "validate"] -> validate.validate(req, cache_subject)
    ["api", "auth", "logout"] -> logout.logout(req, cache_subject)
    _ -> wisp.not_found()
  }
}

fn protected_route(
  req: Request,
  route: #(route.Route, Int),
  admin_only: Bool,
  cache_subject: Subject(CacheMessage),
) -> #(route.Route, Int) {
  case user_session.get_user_from_session(req, cache_subject) {
    Ok(user) ->
      case shared.int_to_is_admin(user.1), admin_only {
        True, _ -> route
        False, False -> route
        False, True -> #(Index, 401)
      }
    Error(_) -> #(Index, 401)
  }
}

fn page_routes(
  req: Request,
  route_segments: List(String),
  cache_subject: Subject(CacheMessage),
) -> Response {
  let #(route, response) = case route_segments {
    [] -> #(Index, 200)
    ["about"] -> #(About, 200)
    ["find-us"] -> #(FindUs, 200)
    ["membership"] -> #(Membership, 200)
    ["events"] -> #(Events, 200)
    ["events", "create-event"] ->
      protected_route(req, #(CreatePost, 200), True, cache_subject)
    ["events", post_slug] ->
      protected_route(req, #(ShowPost(post_slug), 200), False, cache_subject)
    ["repertoire"] -> #(Repertoire, 200)
    ["repertoire", "create-song"] ->
      protected_route(req, #(CreateSong, 200), True, cache_subject)
    ["repertoire", song_slug] ->
      protected_route(req, #(ShowSong(song_slug), 200), False, cache_subject)
    _ -> #(NotFound, 404)
  }

  let model =
    Model(
      route: route,
      create_song_title: "",
      create_song_href: "",
      create_song_error: None,
      login_password: "",
      login_error: None,
      auth_user: case user_session.get_user_from_session(req, cache_subject) {
        Ok(#(_, 1)) -> Some(AuthUser(is_admin: True))
        Ok(_) -> Some(AuthUser(is_admin: False))
        Error(_) -> None
      },
      songs: case route {
        route.Repertoire ->
          case songs.list_songs(req) {
            Ok(songs) -> songs
            Error(_) -> []
          }
        _ -> []
      },
      posts: case route {
        route.Events ->
          case posts.list_posts(req) {
            Ok(posts) -> posts
            Error(_) -> []
          }
        _ -> []
      },
      show_song: case route {
        route.ShowSong(slug) -> {
          case song.show_song(req, slug) {
            Ok(song) -> Some(song)
            Error(_) -> None
          }
        }
        _ -> None
      },
      show_post: case route {
        route.ShowPost(slug) -> {
          case post.show_post(req, slug) {
            Ok(post) -> Some(post)
            Error(_) -> None
          }
        }
        _ -> None
      },
    )

  wisp.response(response)
  |> wisp.set_header("Content-Type", "text-html")
  |> wisp.html_body(
    client.view(model)
    |> scaffold.page_scaffold(encoder.initial_state_encoder(model))
    |> element.to_document_string_builder(),
  )
}
