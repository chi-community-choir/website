import cake/select.{type Select}
import gleam/dynamic/decode
import gleam/json
import gleam/list
import server/db
import shared.{type Post, Post}
import sqlight.{type Value}
import wisp.{type Request}

pub type ListPostDBRow {
  ListPostDBRow(
    post_id: Int,
    post_title: String,
    post_content: String,
    post_excerpt: String,
    post_author: String,
    post_slug: String,
    user_id: Int,
    created_at: String,
    updated_at: String,
  )
}

pub fn get_posts_query() -> Select {
  select.new()
  |> select.selects([])
  |> select.from_table("posts")
  |> select.group_by("posts.id")
  |> select.order_by_desc("posts.created_at")
}

pub fn run_posts_query(select: Select, params: List(Value)) {
  select.to_query(select)
  |> db.execute_read(params, {
    use post_id <- decode.field(0, decode.int)
    use post_title <- decode.field(1, decode.string)
    use post_content <- decode.field(2, decode.string)
    use post_excerpt <- decode.field(3, decode.string)
    use post_author <- decode.field(4, decode.string)
    use post_slug <- decode.field(5, decode.string)
    use user_id <- decode.field(6, decode.int)
    use created_at <- decode.field(7, decode.string)
    use updated_at <- decode.field(8, decode.string)
    decode.success(ListPostDBRow(
      post_id,
      post_title,
      post_content,
      post_excerpt,
      post_author,
      post_slug,
      user_id,
      created_at,
      updated_at,
    ))
  })
}

pub fn post_rows_to_post(_req: Request, rows: List(ListPostDBRow)) {
  use row <- list.map(rows)
  Post(
    id: row.post_id,
    title: row.post_title,
    content: row.post_content,
    excerpt: row.post_excerpt,
    author: row.post_author,
    slug: row.post_slug,
    user_id: row.user_id,
    created_at: row.created_at,
    updated_at: row.updated_at,
    tags: [],
  )
}

pub fn post_rows_to_post_partial(_req: Request, rows: List(ListPostDBRow)) {
  use row <- list.map(rows)
  Post(
    id: row.post_id,
    title: row.post_title,
    content: "",
    excerpt: row.post_excerpt,
    author: row.post_author,
    slug: row.post_slug,
    user_id: row.user_id,
    created_at: row.created_at,
    updated_at: row.updated_at,
    tags: [],
  )
}

pub fn post_to_json(post: Post) {
  json.object([
    #("id", json.int(post.id)),
    #("title", json.string(post.title)),
    #("content", json.string(post.content)),
    #("excerpt", json.string(post.excerpt)),
    #("author", json.string(post.author)),
    #("created_at", json.string(post.created_at)),
    #("updated_at", json.string(post.updated_at)),
    #("tags", json.array(post.tags, fn(tag) { json.string(tag) })),
  ])
}
