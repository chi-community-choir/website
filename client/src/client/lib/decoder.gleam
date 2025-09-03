import client/lib/model.{Model, TestModel}
import client/lib/route
import gleam/dynamic/decode
import gleam/option.{None}
import shared.{Post, Song, User, Admin}

pub fn model_decoder() {
  use auth_user <- decode.field(
    "auth_user",
    decode.optional(auth_user_decoder()),
  )
  use songs <- decode.field("songs", decode.list(song_decoder()))
  use posts <- decode.field("posts", decode.list(post_decoder()))
  use show_song <- decode.field("show_song", decode.optional(song_decoder()))
  use show_post <- decode.field("show_post", decode.optional(post_decoder()))
  decode.success(Model(
    test_model: TestModel(counter: 1),
    route: route.get_route(),
    create_song_title: "",
    create_song_href: "",
    create_song_error: None,
    create_post_title: "",
    create_post_content: "",
    create_post_excerpt: "",
    create_post_author: "",
    create_post_slug: "",
    create_post_preview: "",
    create_post_show_preview: False,
    create_post_error: None,
    delete_post_error: None,
    login_username: "",
    login_password: "",
    login_error: None,
    auth_user: auth_user,
    admin_username: "",
    songs: songs,
    posts: posts,
    posts_search_bar: "",
    show_song: show_song,
    show_post: show_post,
    show_post_html: "",
  ))
}


pub fn auth_user_decoder() {
  use role <- decode.field("role", decode.then(decode.string, fn(role_string) {
    case role_string {
      "user" -> decode.success(User)
      "admin" -> decode.success(Admin)
      _ -> decode.failure(User, "Role")
    }
  }))
  decode.success(role)
}

pub fn song_decoder() {
  use id <- decode.field("id", decode.int)
  use title <- decode.field("title", decode.string)
  use slug <- decode.field("slug", decode.string)
  use href <- decode.field("href", decode.optional(decode.string))
  use filepath <- decode.field("filepath", decode.optional(decode.string))
  use tags <- decode.field("tags", decode.list(decode.string))
  use created_at <- decode.field("created_at", decode.string)
  decode.success(Song(id, title, slug, href, filepath, tags, created_at))
}

pub fn post_decoder() {
  use id <- decode.field("id", decode.int)
  use title <- decode.field("title", decode.string)
  use content <- decode.field("content", decode.string)
  use excerpt <- decode.field("excerpt", decode.string)
  use author <- decode.field("author", decode.string)
  use slug <- decode.field("slug", decode.string)
  use user_id <- decode.field("user_id", decode.int)
  use tags <- decode.field("tags", decode.list(decode.string))
  use created_at <- decode.field("created_at", decode.string)
  use updated_at <- decode.field("updated_at", decode.string)
  decode.success(Post(
    id: id,
    title: title,
    content: content,
    excerpt: excerpt,
    author: author,
    slug: slug,
    user_id: user_id,
    created_at: created_at,
    updated_at: updated_at,
    tags: tags,
  ))
}
