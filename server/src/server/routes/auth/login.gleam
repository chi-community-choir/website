import gleam/list
import server/db
import cake/select
import cake/where
import gleam/bool
import gleam/dynamic
import gleam/dynamic/decode
import gleam/http.{Post}
import gleam/json
import gleam/result
import server/db/user_session
import sqlight
import wisp.{type Request, type Response}

pub fn login(req: Request) -> Response {
  use body <- wisp.require_json(req)

  case req.method {
    Post -> do_login(req, body)
    _ -> wisp.method_not_allowed([Post])
  }
}

type Login {
  Login(as_admin: Bool, username: String, password: String)
}

fn decode_create_user(
  json: dynamic.Dynamic,
) -> Result(Login, List(decode.DecodeError)) {
  let decoder = {
    use as_admin <- decode.field("as_admin", decode.bool)
    use username <- decode.field("username", decode.string)
    use password <- decode.field("password", decode.string)
    decode.success(Login(as_admin, username, password))
  }
  case decode.run(json, decoder) {
    Ok(login) -> Ok(Login(login.as_admin, login.username, login.password))
    Error(error) -> Error(error)
  }
}

fn do_login(req: Request, body: dynamic.Dynamic) -> Response {
  let result = {
    use login <- result.try(case decode_create_user(body) {
      Ok(val) -> Ok(val)
      Error(_) -> Error("Invalid body recieved")
    })

    case login.as_admin {
      False -> {
        use <- bool.guard(
          when: login.password != "test",
          return: Error("Passwords do not match"),
        )
        use session_token <- result.try(user_session.create_user_session(False))
        Ok(session_token)
      }
      True -> {
        // username and password. hashed?
        // check against admin table in db
        let result = {
          select.new()
          |> select.select(select.col("admin.username"))
          |> select.select(select.col("admin.password"))
          |> select.from_table("admin")
          |> select.where(where.eq(where.col("admin.username"), where.string(login.username)))
          |> select.to_query
          |> db.execute_read([sqlight.text(login.username)], {
            use username <- decode.field("username", decode.string)
            use password <- decode.field("password", decode.string)
            decode.success(#(username, password))
          })
        }

        case result |> result.unwrap([]) |> list.first |> result.unwrap(#("", "")) {
          #("", "") -> Error("No user found")
          #(username, password) -> {
            echo "Got admin details"
            echo username
            echo password
            use <- bool.guard(
              when: login.password != password,
              return: Error("Passwords do not match")
            )
            use session_token <- result.try(user_session.create_user_session(True))
            Ok(session_token)
          }
        }
      }
    }

    // use session_token <- result.try(user_session.create_user_session(is_admin)) // TODO: actual admin login

  }

  case result {
    Ok(session_token) ->
      wisp.json_response(
        json.object([#("message", json.string("Logged in"))])
          |> json.to_string_tree,
        201,
      )
      |> wisp.set_cookie(
        req,
        "lf_session_token",
        session_token,
        wisp.PlainText,
        60 * 60 * 24 * 1000,
      )
    Error(error) ->
      wisp.json_response(
        json.object([#("error", json.string(error))])
          |> json.to_string_tree,
        200,
      )
  }
}
