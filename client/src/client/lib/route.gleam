pub type Route {
  NotFound

  Index
  About
  FindUs
  Membership
  Repertoire

  Login
  Signup(auth_code: String)
  CreateSong
  ShowSong(song_id: Int)
}
