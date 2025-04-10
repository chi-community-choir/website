import gleam/dynamic/decode
import gleam/option.{type Option}

pub type Song {
  Song(
    id: Int,
    title: String,
    slug: String,
    href: Option(String),
    filepath: Option(String),
    tags: List(String),
    created_at: String,
  )
}

pub type Post {
  Post(
    id: Int,
    title: String,
    content: String,
    excerpt: String,
    author: String,
    slug: String,
    user_id: Int,
    created_at: String,
    updated_at: String,
    tags: List(String),
  )
}

pub type Tag {
  Tag(id: Int, name: String)
}

pub type AuthUser {
  User
  Admin
}

pub fn auth_user_decoder() -> decode.Decoder(AuthUser) {
  use variant <- decode.then(decode.string)
  case variant {
    "user" -> decode.success(User)
    "admin" -> decode.success(Admin)
    _ -> decode.failure(User, "AuthUser")
  }
}

pub fn authuser_string(role: AuthUser) {
  case role {
    User -> "user"
    Admin -> "admin"
  }
}
