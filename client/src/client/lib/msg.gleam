import client/lib/route.{type Route}
import gleam/dynamic/decode
import gleam/option.{type Option}
import lustre_http
import shared.{type AuthUser, type Post, type Song, Post, Song}

pub type Msg {
  OnRouteChange(Route)

  AuthUserReceived(Result(AuthUser, lustre_http.HttpError))

  SongsReceived(Result(GetSongsResponse, lustre_http.HttpError))
  PostsReceived(Result(GetPostsResponse, lustre_http.HttpError))
  ShowSongReceived(Result(Song, lustre_http.HttpError))
  ShowPostReceived(Result(Post, lustre_http.HttpError))

  RenderPost(content: String)
  PostRendered(rendered_post: String)

  LoginUpdatePassword(value: String)
  LoginUpdateError(value: Option(String))
  RequestLogin
  RequestLogout
  LoginResponded(
    resp_result: Result(MessageErrorResponse, lustre_http.HttpError),
  )
  LogoutResponded(
    resp_result: Result(MessageErrorResponse, lustre_http.HttpError),
  )

  // Dev-only messages for auth state toggling
  ToggleAuthState
  ToggleAdminStatus

  CreateSongUpdateTitle(value: String)
  CreateSongUpdateHref(value: String)
  CreateSongUpdateError(value: Option(String))
  RequestCreateSong
  CreateSongResponded(
    resp_result: Result(MessageErrorResponse, lustre_http.HttpError),
  )
}

pub type GetSongsResponse {
  GetSongsResponse(songs: List(Song))
}

pub type GetPostsResponse {
  GetPostsResponse(posts: List(shared.Post))
}

pub type MessageErrorResponse {
  MessageErrorResponse(message: Option(String), error: Option(String))
}

pub fn message_error_decoder() {
  use message <- decode.field("message", decode.optional(decode.string))
  use error <- decode.field("error", decode.optional(decode.string))
  decode.success(MessageErrorResponse(message: message, error: error))
}
