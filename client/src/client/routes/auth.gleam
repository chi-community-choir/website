import client/env
import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import gleam/json
import lustre/effect.{type Effect}
import lustre_http

// TODO: HASH AUTH INFO BEFORE SENDING TO SERVER. STORE HASHES
// WARN: AUTH INFO SUCEPTIBLE TO CAPTURE IF NOT HASHED

pub fn login(model: Model) -> Effect(Msg) {
  lustre_http.post(
    env.get_api_url() <> "/api/auth/login",
    json.object([
      #("as_admin", json.bool(False)),
      #("username", json.string("")),
      #("password", json.string(model.login_password)),
    ]),
    lustre_http.expect_json(msg.message_error_decoder(), msg.LoginResponded),
  )
}

pub fn admin_login(model: Model) -> Effect(Msg) {
  lustre_http.post(
    env.get_api_url() <> "/api/auth/login",
    json.object([
      #("as_admin", json.bool(True)),
      #("username", json.string(model.login_username)),
      #("password", json.string(model.login_password)),
    ]),
    lustre_http.expect_json(msg.message_error_decoder(), msg.LoginResponded),
  )
}

pub fn logout(_model: Model) -> Effect(Msg) {
  lustre_http.post(
    env.get_api_url() <> "/api/auth/logout",
    json.object([]),
    lustre_http.expect_json(msg.message_error_decoder(), msg.LogoutResponded),
  )
}
