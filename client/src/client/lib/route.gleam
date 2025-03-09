import gleam/uri

pub type Route {
  NotFound

  Index
  About
  FindUs
  Membership
  Repertoire
  Events

  Login
  Signup(auth_code: String)

  CreatePost
  ShowPost(post_slug: String)
  CreateSong
  ShowSong(song_slug: String)
}

@external(javascript, "../ffi.mjs", "get_route")
pub fn do_get_route() -> String

pub fn get_route() -> Route {
  let assert Ok(uri) = do_get_route() |> uri.parse

  case uri.path |> uri.path_segments {
    [] -> Index
    ["about"] -> About
    ["find-us"] -> FindUs
    ["membership"] -> Membership
    ["events"] -> Events
    ["repertoire"] -> Repertoire
    ["create-song"] -> CreateSong
    ["songs", song_slug] -> ShowSong(song_slug)
    _ -> NotFound
  }
}

