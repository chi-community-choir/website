import gleam/erlang/process.{type Subject}
import gleam/http.{Get}
import gleam/io
import gleam/json
import gleam/result
import server/db/user_session
import server/response
import server/routes/cache/session_cache.{type CacheMessage}
import shared
import wisp.{type Request, type Response}

pub fn validate(req: Request, cache_subject: Subject(CacheMessage)) -> Response {
  case req.method {
    Get -> validate_session(req, cache_subject)
    // Post -> create_comment(req)
    _ -> wisp.method_not_allowed([Get])
  }
}

fn validate_session(
  req: Request,
  cache_subject: Subject(CacheMessage),
) -> Response {
  io.println("running validate_session")
  // TODO: Check if the cache call is get_user_from_session is enough
  let result = {
    use #(user_id, role) <- result.try(user_session.get_user_from_session(
      req,
      cache_subject,
    ))
    echo user_id

    Ok(
      json.object([
        #("user_id", user_id |> json.int),
        #("role", role |> shared.authuser_string |> json.string),
      ])
      |> json.to_string_tree,
    )
  }

  response.generate_wisp_response(result)
}
