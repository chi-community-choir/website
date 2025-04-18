import cake/where
import server/db/user_session
import cake/insert
import cake/delete
import gleam/bool
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/http.{Get, Post, Delete}
import gleam/json
import gleam/erlang/process.{type Subject}
import gleam/result
import server/db
import server/db/post
import server/lib
import server/response
import server/routes/cache/session_cache.{type CacheMessage}
import shared.{Admin}
import sqlight
import wisp.{type Request, type Response}

pub fn posts(req: Request, cache_subject: Subject(CacheMessage)) -> Response {
  case req.method {
    Get -> list_posts_res(req)
    Post -> create_post(req, cache_subject)
    Delete -> delete_post(req, cache_subject)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

pub fn list_posts(req: Request, with_content: Bool) -> Result(List(shared.Post), String) {
  case
    post.get_posts_query()
    |> post.run_posts_query([]),
    with_content
  {
    Ok(rows), False -> Ok(post.post_rows_to_post_partial(req, rows))
    Ok(rows), True -> Ok(post.post_rows_to_post(req, rows))
    Error(_), _ -> Error("Selecting posts")
  }
}

pub fn list_posts_res(req: Request) -> Response {
  let query = case post.get_posts_query() |> post.run_posts_query([]) {
    Ok(rows) -> Ok(rows)
    Error(_) -> Error("Selecting posts - RES")
  }

  case query {
    Ok(rows) ->
      Ok(
        json.object([
          #(
            "posts",
            post.post_rows_to_post(req, rows)
              |> json.array(fn(post) { post.post_to_json(post) }),
          ),
        ])
        |> json.to_string_tree,
      )
    Error(error) -> Error(error)
  }
  |> response.generate_wisp_response
}

type CreatePost {
  CreatePost(
    title: String,
    content: String,
    excerpt: String,
    author: String,
    slug: String,
    user_id: Int,
    tags: List(Int),
  )
}

fn decode_create_post(
  json: Dynamic,
  user_id: Int
) -> Result(CreatePost, List(decode.DecodeError)) {
  let decoder = {
    use title <- decode.field("title", decode.string)
    use content <- decode.field("content", decode.string)
    use excerpt <- decode.field("excerpt", decode.string)
    use author <- decode.field("author", decode.string)
    use slug <- decode.field("slug", decode.string)
    // use tags <- decode.field("tags", decode.list(decode.int))
    decode.success(CreatePost(title, content, excerpt, author, slug, user_id, []))
  }
  decode.run(json, decoder)
}

fn insert_post_to_db(_req: Request, post: CreatePost) {
  let slug = post.title |> lib.title_to_slug
  let _ =
    [
      insert.row([
        insert.string(post.title),
        insert.string(post.content),
        insert.string(post.excerpt),
        insert.string(post.author),
        insert.string(slug),
        insert.int(post.user_id),
      ]),
    ]
    |> insert.from_values(table_name: "posts", columns: [
      "title", "content", "excerpt", "author", "slug", "user_id",
    ])
    |> insert.to_query
    |> db.execute_write([
      sqlight.text(post.title),
      sqlight.text(post.content),
      sqlight.text(post.excerpt),
      sqlight.text(post.author),
      sqlight.text(post.slug),
      sqlight.int(post.user_id),
    ])
  Ok(Nil)
}

pub fn create_post(req: Request, subject: Subject(CacheMessage)) -> Response {
  use body <- wisp.require_json(req)

  {
    use #(user_id, _) <- result.try(
      user_session.get_user_from_session(req, subject) |> result.replace_error("Not authenticated")
    )
    use post <- result.try(case decode_create_post(body, user_id) {
      Ok(val) -> Ok(val)
      Error(_) -> Error("Invalid request body received")
    })

    use <- bool.guard(
      when: post.title == "",
      return: Error("No title provided"),
    )

    use <- bool.guard(
      when: post.content == "",
      return: Error("No post body provided"),
    )

    use _ <- result.try(case insert_post_to_db(req, post) {
      Ok(_) -> Ok(Nil)
      Error(_) -> Error("Problem creating post")
    })

    Ok(
      json.object([#("message", json.string("Created post"))])
      |> json.to_string_tree,
    )
  } |> response.generate_wisp_response

}

fn delete_post_from_db(slug: String) {
  case delete.new()
  |> delete.table("posts")
  |> delete.where(where.eq(where.col("posts.id"), where.string(slug)))
  |> delete.to_query
  |> db.execute_write([sqlight.text(slug)])
  {
    Ok(_) -> Ok(Nil)
    Error(e) -> Error("Failed to delete post: " <> e.message)
  }
}

fn delete_post(req: Request, subject: Subject(CacheMessage)) {
  {
  use slug <- result.try(
    case wisp.path_segments(req) {
      ["api", "posts", slug] -> Ok(slug)
      _ -> Error("Invalid URL path")
    }
  )

  use #(_, role) <- result.try(
    user_session.get_user_from_session(req, subject)
    |> result.replace_error("Not authenticated")
  )

  use <- bool.guard(
    when: role != Admin,
    return: Error("Unauthorized")
  )

  use _ <- result.try(
    delete_post_from_db(slug)
  )

  Ok(
    json.object([#("message", json.string("Post deleted successfully"))])
    |> json.to_string_tree
  )

  } |> response.generate_wisp_response
}
