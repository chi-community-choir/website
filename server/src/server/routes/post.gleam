import cake/select
import cake/where
import gleam/http.{Get}
import gleam/json
import gleam/list
import gleam/result
import server/db/post
import server/response
import shared
import sqlight
import wisp.{type Request, type Response}

pub fn post(req: Request, post_slug: String) -> Response {
  case req.method {
    Get -> show_post_res(req, post_slug)
    _ -> wisp.method_not_allowed([Get])
  }
}

pub fn show_post(req: Request, post_slug: String) -> Result(shared.Post, String) {
  use post_rows <- result.try(
    post.get_post_query()
    |> select.where(where.eq(where.col("posts.slug"), where.string(post_slug)))
    |> post.run_post_query([sqlight.text(post_slug)])
    |> result.replace_error("problem getting post from database"),
  )

  use post <- result.try(
    post.post_rows_to_post(req, post_rows)
    |> list.first
    |> result.replace_error("No post found"),
  )

  Ok(post)
}

fn show_post_res(req: Request, post_slug: String) -> Response {
  response.generate_wisp_response(case show_post(req, post_slug) {
    Ok(post) -> Ok(post |> post.post_to_json |> json.to_string_tree)
    Error(_) -> Error("Problem getting post from database - RES")
  })
}
