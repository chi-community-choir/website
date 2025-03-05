import cake/select.{type Select}
import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import server/db
import shared.{type Post, Post}
import sqlight.{type Value}
import wisp.{type Request}

pub type ListPostDBRow {
  ListPostDBRow(
    post_id: Int,
    post_title: String,
    post_content: String,
    created_at: Int,
  )
}

pub fn get_post_query() -> Select {
  select.new()
  |> select.selects([])
  |> select.from_table("post")
  |> select.group_by("post.id")
  |> select.order_by_desc("post.created_at")
}

pub fn run_post_query(select: Select, params: List(Value)) {
  select.to_query(select)
  |> db.execute_read(params,
    {
    use post_id <- decode.field(0, decode.int)
    use post_title <- decode.field(1, decode.string)
    use post_content <- decode.field(2, decode.string)
    use created_at <- decode.field(3, decode.int)
    decode.success(ListPostDBRow(post_id, post_title, post_content, created_at))
    }
  )
}

pub fn post_rows_to_post(_req: Request, rows: List(ListPostDBRow)) {
  use row <- list.map(rows)
  Post(
    id: row.post_id,
    title: row.post_title,
    content: row.post_content,
    tags: [],
    created_at: row.created_at,
  )
}

pub fn post_to_json(post: Post) {
  json.object([
    #("id", json.int(post.id)),
    #("title", json.string(post.title)),
    #("content", json.string(post.content)),
    #("tags", json.array(post.tags, fn(tag) { json.string(tag) })),
    #("created_at", json.int(post.created_at)),
  ])
}
