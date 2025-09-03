import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import gleam/list
import gleam/option.{None, Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import shared.{User, Admin}

pub fn navbar(model: Model) -> Element(Msg) {
  html.div(
    [
      attribute.styles([
        #("background-color", "#40359b"),
        #("text-align", "center"),
      ]),
    ],
    [
      html.nav(
        [
          attribute.styles([
            #("display", "flex"),
            #("justify-content", "center"),
            #("align-items", "center"),
            #("gap", "1rem"),
            #("flex-wrap", "wrap"),
          ]),
        ],
        [
          navbutton("/", "Home"),
          navbutton("/about", "About"),
          navbutton("/find-us", "Find Us"),
          navbutton("/membership", "Membership"),
          navbutton("/events", "Events"),
          navbutton("/repertoire", "Repertoire"),
        ]
          |> list.append(case model.auth_user {
            None -> [
              // TODO: msg.RequestLogin event on enter
              html.div([], [
                html.input([
                  event.on_input(msg.LoginUpdatePassword),
                  attribute.placeholder("Enter password"),
                  attribute.styles([
                    // #("font-size", "1.1rem"),
                    // #("padding", "0.5rem 1rem"),
                    // #("margin", "0 1rem"),
                    #("border-radius", "4px"),
                    #("border", "2px solid #ccc"),
                  ]),
                ]),
                html.button(
                  [
                    event.on_click(msg.RequestLogin(as_admin: False)),
                    attribute.styles([
                      #("font-size", "1.1rem"),
                      #("padding", "0.5rem 1.5rem"),
                      #("background-color", "#2c5282"),
                      #("border-radius", "4px"),
                      #("transition", "all 0.2s ease-in-out"),
                      #("cursor", "pointer"),
                    ]),
                  ],
                  [element.text("Login")],
                ),
              ]),
            ]
            Some(user) -> {
              case user {
                User -> [
                  html.button(
                    [event.on_click(msg.RequestLogout)],
                    [element.text("Log out")],
                  ),
                ]
                Admin -> {
                  [
                    navbutton("/status-test", "Status"),
                    html.button(
                      [event.on_click(msg.RequestLogout)],
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
            html.div(
              [
                attribute.styles([
                  #("display", "flex"),
                  #("gap", "0.5rem"),
                  #("background-color", "#f8d7da"),
                  #("padding", "0.5rem"),
                  #("border-radius", "4px"),
                  #("border", "1px dashed #dc3545"),
                ]),
              ],
              [
                html.div([], [element.text("DEV: ")]),
                html.button(
                  [
                    event.on_click(msg.ToggleAuthState),
                    attribute.styles([
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
                  ],
                  [
                    element.text(case model.auth_user {
                      None -> "Login"
                      Some(_) -> "Logout"
                    }),
                  ],
                ),
                html.button(
                  [
                    event.on_click(msg.ToggleAdminStatus),
                    attribute.styles([
                      #("font-size", "0.8rem"),
                      #("padding", "0.25rem 0.5rem"),
                      #("background-color", case model.auth_user {
                        None -> "#6c757d"
                        Some(user) ->
                          case user {
                            Admin -> "#dc3545"
                            User -> "#007bff"
                          }
                      }),
                      #("border-radius", "4px"),
                      #("color", "white"),
                      #("cursor", "pointer"),
                    ]),
                  ],
                  [
                    element.text(case model.auth_user {
                      None -> "Admin: Off"
                      Some(user) ->
                        case user {
                          Admin -> "Admin: On"
                          User -> "Admin: Off"
                        }
                    }),
                  ],
                ),
              ],
            ),
          ]),
      ),
      html.hr([attribute.styles([#("opacity", "0")])]),
    ],
  )
}

fn navbutton(href: String, title: String) {
  let style = "
    .nav-link {
      text-decoration: none;
      display: inline-block;
    }

    .nav-button {
      background-color: #ffffff;
      color: black;
      font-size: 1.2rem;
      font-weight: 600;
      border-radius: 8px;
      border: 2px solid #000000;
      transition: all 0.2s ease-in-out;
      cursor: pointer;
    }

    .nav-button:hover {
      background-color: #f0f4f8;
      border-color: #2c5282;
    }

    .nav-button:focus {
      outline: 3px solid #90cdf4;
      outline-offset: 2px;
    }

    .nav-button:active {
      transform: translateY(1px);
    }
  "

  html.div([], [
    html.style([], style),
    html.a(
      [
        attribute.href(href),
        attribute.class("nav-link"),
      ],
      [
        html.button(
          [
            attribute.class("nav-button"),
          ],
          [element.text(title)],
        ),
      ],
    ),
  ])
}
