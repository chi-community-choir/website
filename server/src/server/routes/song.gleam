import cake/select
import cake/where
import gleam/http.{Get}
import gleam/json
import gleam/list
import gleam/result
import server/db/song
import server/response
import shared
import sqlight
import wisp.{type Request, type Response}

pub fn song(req: Request, song_slug: String) -> Response {
  case req.method {
    Get -> show_song_res(req, song_slug)
    _ -> wisp.method_not_allowed([Get])
  }
}

pub fn show_song(req: Request, song_slug: String) -> Result(shared.Song, String) {
  use song_rows <- result.try(
    song.get_songs_query()
    |> select.where(where.eq(where.col("song.slug"), where.string(song_slug)))
    |> song.run_song_query([sqlight.text(song_slug)])
    |> result.replace_error("problem getting song from database"),
  )

  use song <- result.try(
    song.song_rows_to_song(req, song_rows)
    |> list.first
    |> result.replace_error("No song found"),
  )

  Ok(song)
}

fn show_song_res(req: Request, song_slug: String) -> Response {
  response.generate_wisp_response(case show_song(req, song_slug) {
    Ok(song) -> Ok(song |> song.song_to_json |> json.to_string_tree)
    Error(_) -> Error("Problem getting song from database")
  })
}
