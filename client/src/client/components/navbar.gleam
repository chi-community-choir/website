import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import gleam/list
import gleam/option.{None, Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import lustre/ui
import lustre/ui/button
import lustre/ui/classes

pub fn navbar(model: Model) -> Element(Msg) {
  html.div(
    [
      classes.shadow_md(),
      classes.py_md(),
      attribute.style([
        #("background-color", "#40359b"),
        #("text-align", "center"),
      ]),
    ],
    [
      html.nav(
        [
          attribute.style([
            #("display", "flex"),
            #("justify-content", "center"),
            #("align-items", "center"),
            #("gap", "1rem"),
            #("flex-wrap", "wrap"),
          ]),
        ],
        [
          navbutton("/", "Home"),
          navbutton("about", "About"),
          navbutton("find-us", "Find Us"),
          
        ]
        |> list.append(case model.auth_user {
          None -> [
            // TODO: msg.RequestLogin event on enter
            html.div([], [
              ui.input([
                event.on_input(msg.LoginUpdatePassword),
                attribute.placeholder("Enter password"),
                attribute.style([
                  // #("font-size", "1.1rem"),
                  // #("padding", "0.5rem 1rem"),
                  // #("margin", "0 1rem"),
                  #("border-radius", "4px"),
                  #("border", "2px solid #ccc"),
                ]),
              ]),
              ui.button([
                button.solid(),
                event.on_click(msg.RequestLogin),
                attribute.style([
                  #("font-size", "1.1rem"),
                  #("padding", "0.5rem 1.5rem"),
                  #("background-color", "#2c5282"),
                  #("border-radius", "4px"),
                  #("transition", "all 0.2s ease-in-out"),
                  #("cursor", "pointer"),
                ]),
              ], [
                element.text("Login"),
              ]),
            ])
          ]
          Some(user) -> {
            case user.is_admin {
              False -> [
                navbutton("songs", "Songs"),
                ui.button(
                  [button.solid(), event.on_click(msg.RequestLogout)],
                  [element.text("Log out")],
                ),
              ]
              True -> {
                [
                  navbutton("songs", "Songs"),
                  navbutton("create-post", "Create new post"),
                  ui.button(
                    [button.solid(), event.on_click(msg.RequestLogout)],
                    [element.text("Log out")],
                  ),
                ]
              }
            }
          }
        })
        |> list.append([
          // Dev-only authentication toggle buttons
          // WARN: Remove in prod
          html.div([
            attribute.style([
              #("display", "flex"),
              #("gap", "0.5rem"),
              #("background-color", "#f8d7da"),
              #("padding", "0.5rem"),
              #("border-radius", "4px"),
              #("border", "1px dashed #dc3545"),
            ]),
          ], [
            html.div([], [
              element.text("DEV: "),
            ]),
            ui.button([
              button.solid(),
              event.on_click(msg.ToggleAuthState),
              attribute.style([
                #("font-size", "0.8rem"),
                #("padding", "0.25rem 0.5rem"),
                #("background-color", case model.auth_user {
                  None -> "#6c757d"
                  Some(_) -> "#28a745"
                }),
                #("border-radius", "4px"),
                #("color", "white"),
                #("cursor", "pointer"),
              ]),
            ], [
              element.text(case model.auth_user {
                None -> "Login"
                Some(_) -> "Logout"
              }),
            ]),
            ui.button([
              button.solid(),
              event.on_click(msg.ToggleAdminStatus),
              attribute.style([
                #("font-size", "0.8rem"),
                #("padding", "0.25rem 0.5rem"),
                #("background-color", case model.auth_user {
                  None -> "#6c757d"
                  Some(user) -> case user.is_admin {
                    True -> "#dc3545"
                    False -> "#007bff"
                  }
                }),
                #("border-radius", "4px"),
                #("color", "white"),
                #("cursor", "pointer"),
              ]),
            ], [
              element.text(case model.auth_user {
                None -> "Admin: Off"
                Some(user) -> case user.is_admin {
                  True -> "Admin: On"
                  False -> "Admin: Off"
                }
              }),
            ]),
          ])
        ])
      ),
      html.hr([attribute.style([#("opacity", "0")])]),
    ],
  )
}

fn navbutton(href: String, title: String) {
  html.a([
    attribute.href(href),
    attribute.style([
      #("text-decoration", "none"),
      #("display", "inline-block"),
    ]),
  ], [
    ui.button([
      button.solid(),
      attribute.style([
        #("background-color", "#ffffff"),
        #("color", "black"),
        #("font-size", "1.2rem"),
        #("font-weight", "600"),
        // #("padding", "0.75rem 1.5rem"),
        #("border-radius", "8px"),
        #("border", "2px solid transparent"),
        #("border-color", "#000000"),
        #("transition", "all 0.2s ease-in-out"),
        #("cursor", "pointer"),
        // Hover states
        #("&:hover", "background-color: #f0f4f8; border-color: #2c5282;"),
        #("&:focus", "outline: 3px solid #90cdf4; outline-offset: 2px;"),
        // Active state
        #("&:active", "transform: translateY(1px)"),
      ]),
    ], [element.text(title)]),
  ])
}
