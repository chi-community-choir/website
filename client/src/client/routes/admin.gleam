import gleam/option.{Some, None}
import lustre/attribute
import lustre/event
import lustre/element.{type Element}
import lustre/element/html
import lustre/ui/button
import lustre/ui/input
import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import shared.{AuthUser}

pub fn admin(model: Model) -> Element(Msg) {
  html.div([attribute.id("admin-login-page")], [
    // flex, column flow, centered, etc
    html.style([], "
      #admin-login-page {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background-color: #f3f4f6;
      }

      #admin-login-container {
        background-color: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 
                    0 2px 4px -1px rgba(0, 0, 0, 0.06);
        width: 100%;
        max-width: 400px;
      }

      #admin-login-header {
        text-align: center;
        margin-bottom: 2rem;
      }

      #admin-login-header h1 {
        color: #1a202c;
        font-size: 1.875rem;
        font-weight: 600;
      }

      #admin-login-form {
        display: flex;
        flex-direction: column;
        gap: 1rem;
      }

      #admin-login-form input {
        padding: 0.75rem;
        border: 1px solid #e2e8f0;
        border-radius: 4px;
        font-size: 1rem;
        width: 100%;
        box-sizing: border-box;
      }

      #admin-login-form input:focus {
        outline: none;
        border-color: #4299e1;
        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
      }

      #admin-login-form button {
        padding: 0.75rem;
        background-color: #4299e1;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.2s;
      }

      #admin-login-form button:hover {
        background-color: #3182ce;
      }

      #admin-login-form button:focus {
        outline: none;
        box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
      }
    "),
    html.div([attribute.id("admin-login-container")],
      case model.auth_user {
        Some(AuthUser(is_admin: True)) -> [
          html.div([attribute.id("admin-login-header")], [
            html.h1([], [element.text("Welcome, Admin")]),
            html.p([
              attribute.style([#("margin-top", "1rem"), #("color", "#4a5568")]),
            ], [
              element.text("You are already logged in as an administrator."),
            ]),
          ]),
          html.div([attribute.id("admin-login-form")], [
            html.button([
              event.on_click(msg.RequestLogout),
              attribute.style([#("background-color", "#e53e3e")]),
            ], [
              element.text("Log Out"),
            ]),
          ]),
        ]
        _ ->  [
          html.div([attribute.id("admin-login-header")], [
            html.h1([], [element.text("Admin Login")])
          ]),
          html.div([attribute.id("admin-login-form")], [
            // input, input, button
            html.input([
              attribute.placeholder("Username"),
              event.on_input(msg.LoginUpdateUsername),
            ]),
            html.input([
              attribute.placeholder("Password"),
              event.on_input(msg.LoginUpdatePassword),
            ]),
            html.button([event.on_click(msg.RequestLogin(as_admin: True))], [element.text("Admin Login")]),
          ]),
        ]
      }
    ),
  ])
}
