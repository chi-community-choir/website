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
