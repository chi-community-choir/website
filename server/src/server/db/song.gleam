import cake/select.{type Select}
import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/option.{type Option}
import server/db
import shared.{type Song, Song}
import sqlight.{type Value}
import wisp.{type Request}

pub type ListSongsDBRow {
  ListSongsDBRow(
    song_id: Int,
    song_title: String,
    song_slug: String,
    song_href: Option(String),
    song_filepath: Option(String),
    created_at: String,
  )
}

pub fn get_songs_query() -> Select {
  select.new()
  |> select.selects([])
  |> select.from_table("songs")
  |> select.group_by("songs.id")
  |> select.order_by_desc("songs.created_at")
}

pub fn run_song_query(select: Select, params: List(Value)) {
  select.to_query(select)
  |> db.execute_read(params, {
    use song_id <- decode.field(0, decode.int)
    use song_title <- decode.field(1, decode.string)
    use song_slug <- decode.field(2, decode.string)
    use song_href <- decode.field(3, decode.optional(decode.string))
    use song_filepath <- decode.field(4, decode.optional(decode.string))
    use created_at <- decode.field(5, decode.string)
    decode.success(ListSongsDBRow(
      song_id,
      song_title,
      song_slug,
      song_href,
      song_filepath,
      created_at,
    ))
  })
}

pub fn song_rows_to_song(_req: Request, rows: List(ListSongsDBRow)) {
  use row <- list.map(rows)
  Song(
    id: row.song_id,
    title: row.song_title,
    slug: row.song_slug,
    href: row.song_href,
    filepath: row.song_filepath,
    tags: [],
    created_at: row.created_at,
  )
}

pub fn song_to_json(song: Song) {
  json.object([
    #("id", json.int(song.id)),
    #("title", json.string(song.title)),
    #("slug", json.string(song.slug)),
    #("href", json.nullable(song.href, json.string)),
    #("href", json.nullable(song.filepath, json.string)),
    #("tags", json.array(song.tags, fn(tag) { json.string(tag) })),
    #("created_at", json.string(song.created_at)),
  ])
}
