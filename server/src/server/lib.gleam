import gleam/function
import client/lib/model.{type Model}
import gleam/int
import gleam/dict
import gleam/json.{type Json}
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

fn auth_user_encoder(auth_user: AuthUser) -> Json {
  json.object([
    #("is_admin", json.bool(auth_user.is_admin)),
  ])
}

fn songs_encoder(songs: List(Song)) -> List(Json) {
  songs
  |> list.map(song_encoder)
}

fn song_encoder(song: Song) -> Json {
  json.object([
    #("id", json.int(song.id)),
    #("title", json.string(song.title)),
    #("slug", json.string(song.slug)),
    #("href", json.nullable(song.href, json.string)),
    #("filepath", json.nullable(song.filepath, json.string)),
    #("tags", json.array(song.tags, json.string)),
    #("created_at", json.string(song.created_at)),
  ])
}

fn posts_encoder(posts: List(Post)) -> List(Json) {
  posts
  |> list.map(post_encoder)
}

fn post_encoder(post: Post) -> Json {
  json.object([
    #("id", json.int(post.id)),
    #("title", json.string(post.title)),
    #("content", json.string(post.content)),
    #("excerpt", json.string(post.excerpt)),
    #("author", json.string(post.author)),
    #("slug", json.string(post.slug)),
    #("tags", json.array(post.tags, json.string)),
    #("created_at", json.string(post.created_at)),
    #("updated_at", json.string(post.updated_at)),
  ])
}

pub fn initial_state_encoder(model: Model) -> String {
  [
    #("auth_user", case model.auth_user {
      Some(auth_user) -> json.object([#("is_admin", json.bool(auth_user.is_admin))])
      None -> json.null()
    }),
    #("songs", json.array(model.songs |> songs_encoder, function.identity)),
    #("posts", json.array(model.posts |> posts_encoder, function.identity)),
    #("show_song", case model.show_song {
      Some(song) -> song_encoder(song)
      None -> json.null()
    }),
  ]
  |> json.object
  |> json.to_string
}

