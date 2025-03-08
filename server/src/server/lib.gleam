import client/lib/model.{type Model}
import gleam/int
import gleam/json
import gleam/dynamic.{type Dynamic}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import shared.{type AuthUser, type Post, type Song, AuthUser, Song}

pub fn title_to_slug(title: String) -> String {
  title
  |> string.trim()
  |> string.lowercase()
  |> string.replace(" ", "-")
}

fn auth_user_encoder(auth_user: Option(AuthUser)) {
  case auth_user {
    Some(auth_user) -> case auth_user {
      AuthUser(is_admin) -> is_admin |> shared.is_admin_to_int
    }
    None -> 2
  }
}

fn songs_encoder(songs: List(Song)) -> List(List(String)) {
  songs
  |> list.map(fn(song) {
    [
      int.to_string(song.id),
      song.title,
      song.slug,
      option.unwrap(song.href, ""),
      option.unwrap(song.filepath, ""),
      string.join(song.tags, ","),
      song.created_at,
    ]
  })
}

fn posts_encoder(posts: List(Post)) -> List(List(String)) {
  posts
  |> list.map(fn(post) {
    [
      int.to_string(post.id),
      post.title,
      post.content,
      post.author,
      post.excerpt,
      post.slug,
      string.join(post.tags, ","),
      post.created_at,
      post.updated_at,
    ]
  })
}

pub fn initial_state_encoder(model: Model) -> String {
  json.object([
    #("auth_user", json.int(model.auth_user |> auth_user_encoder)),
    #("songs", json.array(model.songs |> songs_encoder, json.array(_, json.string))),
    #("posts", json.array(model.posts |> posts_encoder, json.array(_, json.string))),
  ])
  |> json.to_string
}

