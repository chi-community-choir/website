import client/lib/route.{type Route}
import gleam/option.{type Option}
import shared.{type AuthUser, type Post, type Song}

pub type Model {
  Model(
    route: Route,
    create_song_title: String,
    create_song_href: String,
    create_song_error: Option(String),
    create_post_title: String,
    create_post_content: String,
    create_post_excerpt: String,
    create_post_author: String,
    create_post_slug: String,
    create_post_error: Option(String),
    login_password: String,
    login_error: Option(String),
    auth_user: Option(AuthUser),
    songs: List(Song),
    posts: List(Post),
    show_song: Option(Song),
    show_post: Option(Post),
    show_post_html: String,
  )
}
