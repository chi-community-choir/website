import cake/insert
import gleam/bool
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/http.{Get, Post}
import gleam/json
import gleam/result
import server/db
import server/db/post
import server/lib
import server/response
import shared
import sqlight
import wisp.{type Request, type Response}

pub fn posts(req: Request) -> Response {
  case req.method {
    Get -> list_posts_res(req)
    Post -> create_post(req)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

pub fn list_posts(req: Request) -> Result(List(shared.Post), String) {
  case
    post.get_post_query()
    |> post.run_post_query([])
  {
    Ok(rows) -> Ok(post.post_rows_to_post(req, rows))
    Error(_) -> Error("Selecting posts")
  }
}

pub fn list_posts_res(req: Request) -> Response {
  let query = case post.get_post_query() |> post.run_post_query([]) {
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
    tags: List(Int),
  )
}

fn decode_create_post(json: Dynamic) -> Result(CreatePost, List(decode.DecodeError)) {
  let decoder = {
    use title <- decode.field("title", decode.string)
    use content <- decode.field("content", decode.string)
    use excerpt <- decode.field("excerpt", decode.string)
    use author <- decode.field("author", decode.string)
    use tags <- decode.field("tags", decode.list(decode.int))
    decode.success(CreatePost(title, content, excerpt, author, tags))
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
        insert.string(slug)
      ]),
    ]
    |> insert.from_values(table_name: "posts", columns: [
      "title",
      "content",
      "excerpt",
      "author",
      "slug",
    ])
    |> insert.to_query
    |> db.execute_write([
      sqlight.text(post.title),
      sqlight.text(post.content),
      sqlight.text(post.excerpt),
      sqlight.text(post.author),
      sqlight.text(slug),
    ])
  Ok(Nil)
}


pub fn create_post(req: Request) -> Response {
  use body <- wisp.require_json(req)

  let result = {
    use post <- result.try(case decode_create_post(body) {
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
  }

  response.generate_wisp_response(result)
}
