import gleam/function
import gleam/list
import gleam/json.{type Json}
import gleam/option.{None, Some}
import client/lib/model.{type Model}
import shared.{type Song, type Post, Song, Post}

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
    #("show_post", case model.show_post {
      Some(post) -> post_encoder(post)
      None -> json.null()
    }),
  ]
  |> json.object
  |> json.to_string
}
