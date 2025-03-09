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

fn auth_user_encoder(auth_user: Option(AuthUser)) -> Option(Bool) {
  case auth_user {
    Some(auth_user) -> case auth_user {
      AuthUser(is_admin) -> Some(is_admin)
    }
    None -> None
  }
}

fn songs_encoder(songs: List(Song)) -> List(String) {
  songs
  |> list.map(song_encoder)
}

fn song_encoder(song: Song) -> String {
  [
    #("id", json.int(song.id)),
    #("title", json.string(song.title)),
    #("slug", json.string(song.slug)),
    #("href", json.nullable(song.href, json.string)),
    #("filepath", json.nullable(song.filepath, json.string)),
    #("tags", json.array(song.tags, json.string)),
    #("created_at", json.string(song.created_at)),
  ] |> json.object |> json.to_string
}

fn posts_encoder(posts: List(Post)) -> List(String) {
  posts
  |> list.map(post_encoder)
}

fn post_encoder(post: Post) -> String {
    [
      #("id", json.int(post.id)),
      #("title", json.string(post.title)),
      #("content", json.string(post.content)),
      #("author", json.string(post.author)),
      #("excerpt", json.string(post.excerpt)),
      #("slug", json.string(post.slug)),
      #("tags", json.array(post.tags, json.string)),
      #("created_at", json.string(post.created_at)),
      #("updated_at", json.string(post.updated_at)),
    ] |> json.object |> json.to_string
}

pub fn initial_state_encoder(model: Model) -> String {
  [
    #("auth_user", json.nullable(model.auth_user |> auth_user_encoder, json.bool)),
    #("songs", json.array(model.songs |> songs_encoder, json.string)),
    #("posts", json.array(model.posts |> posts_encoder, json.string)),
  ]
  |> json.object
  |> json.to_string
}

