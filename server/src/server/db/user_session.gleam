import cake/insert
import cake/select
import cake/where
import cake/join
import gleam/dynamic/decode
import gleam/erlang/process.{type Subject}
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import server/db
import server/routes/cache/session_cache.{type CacheMessage, CacheEntry}
import server/token.{generate_token}
import shared.{type AuthUser}
import sqlight
import wisp.{type Request}

/// Returns Result(#(user_id, AuthUser), Nil)
pub fn get_user_from_session(
  req: Request,
  cache_subject: Subject(CacheMessage),
) -> Result(#(Int, AuthUser), String) {
  let result = {
    use req_session_token <- result.try(
      wisp.get_cookie(req, "lf_session_token", wisp.PlainText)
      |> result.replace_error("No session cookie found"),
    )

    case session_cache.cache_get(cache_subject, req_session_token) {
      Some(CacheEntry(id, role, _)) -> {
        io.println("Got user from cache")
        Ok(#(id, role)) |> echo
      }
      None -> {
        let session_token_result = case
          select.new()
          |> select.selects([
            select.col("sessions.user_id"),
            select.col("users.role"),
          ])
          |> select.from_table("sessions")
          |> select.join(
            join.inner(
              alias: "users",
              on: where.eq(
                where.col("sessions.user_id"),
                where.col("users.id"),
              ),
              with: join.table("users"),
            )
          )
          |> select.where(where.eq(
            where.col("sessions.token"),
            where.string(req_session_token),
          ))
          |> select.to_query
          |> db.execute_read([sqlight.text(req_session_token)], {
            use id <- decode.field(0, decode.int)
            use role <- decode.field(1, shared.auth_user_decoder())
            decode.success(#(id, role))
          })
        {
          Ok(users) -> {
            let user_result = list.first(users)
            case user_result {
              Ok(user) -> {
                let #(id, role) = user
                io.println("Validated user from db, putting in cache.")
                session_cache.cache_put(
                  cache_subject,
                  req_session_token,
                  id,
                  role,
                )
              }
              Error(_) -> io.println("User result was error??")
            }
            Ok(user_result) |> echo
          }
          Error(e) -> {
            Error(
              "Problem getting user_session by token: "
              <> e.message
              <> " -- with token: "
              <> req_session_token,
            )
          }
        }

        use user_id_result <- result.try(session_token_result)
        case user_id_result {
          Ok(id) -> Ok(id)
          Error(_) ->
            Error("No user_session found when getting user_session by token")
        }
      }
    }
  }
  io.println(
    "result: " <> result.unwrap_error(result, "user id obtained from session."),
  )
  result
}

pub fn create_user_session(user_id: Int) {
  let token = generate_token(64)

  let result =
    [insert.row([insert.int(user_id), insert.string(token)])]
    |> insert.from_values(table_name: "sessions", columns: [
      "user_id", "token",
    ])
    |> insert.to_query
    |> db.execute_write([sqlight.int(user_id), sqlight.text(token)])

  case result {
    Ok(_) -> {
      Ok(token)
    }
    Error(err) ->
      Error(
        "Creating user session:" <> err.message,
      )
  }
}
