import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import client/styles
import gleam/list
import gleam/option.{None, Some}
import gleam/string
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import shared.{type Post, Admin}

pub fn events(model: Model) {
  html.div([], [
    html.div(
      [attribute.styles([#("display", "flex"), #("justify-content", "center")])],
      [html.h1([], [element.text("Events")])],
    ),
    html.div(
      [
        attribute.styles([
          #("display", "flex"),
          #("flex-direction", "column"),
          #("justify-content", "left"),
          #("padding", "0 20%"),
        ]),
      ],
      [
        // search bar, admin "create post" button
        html.input([
          event.on_input(msg.PostUpdateSearchBar),
          attribute.placeholder("Search Posts:"),
          attribute.styles([
            #("border-radius", "4px"),
            #("border", "2px solid #ccc"),
          ]),
        ]),
        case model.auth_user {
          Some(Admin) -> {
            html.a([attribute.href("/events/create-post")], [
              html.button([], [element.text("Create New Post")]),
            ])
          }
          _ -> element.none()
        },
      ]
        // All posts as cards
        |> list.append(case model.posts {
          [] -> [element.text("no posts found")]
          posts -> {
            let filtered_posts =
              posts
              |> list.filter(fn(post) {
                post.title |> string.contains(model.posts_search_bar)
              })
            use each_post <- list.map(filtered_posts)
            html.div([], [
              html.styles(
                [],
                "
                .post-card {
                  justify-content: left;
                  background-color: #e5f4ff;
                  border-radius: 8px;
                  border: 1px solid #e2e8f0;
                  padding: 1.5rem;
                  margin: 1rem 0;
                  transition: all 0.2s ease-in-out;
                  cursor: pointer;
                  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                  width: 100%;
                }
                .post-card:hover {
                  transform: translateY(-2px);
                  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                  border-color: #2c5282;
                }
              ",
              ),
              html.a([attribute.href("/events/" <> each_post.slug)], [
                html.div(
                  [
                    attribute.class("post-card"),
                  ],
                  [
                    html.div([], [post(model, each_post)]),
                  ],
                ),
              ]),
            ])
          }
        }),
    ),
  ])
}

pub fn post(_model: Model, post: Post) -> Element(Msg) {
  html.div(
    [
      attribute.styles([]),
    ],
    [
      html.h1(
        [
          // classes.text_2xl()
        ],
        [
          html.strong([], [element.text(post.title)]),
        ],
      ),
      html.p(
        [
          // classes.text_lg()
        ],
        [element.text(post.excerpt)],
      ),
    ],
  )
}

pub fn create_post(model: Model) {
  html.div([], [
    html.styles(
      [],
      "
      .create-post-container {
        display: flex;
        gap: 2rem;
        padding: 0 2rem;
        flex-direction: column;
      }

      @media (min-width: 1200px) {
        .create-post-container {
          flex-direction: row;
        }
      }

      .create-post-form {
        flex: 1;
        min-width: 0;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 2rem;
      }

      .create-post-preview {
        flex: 1;
        min-width: 0;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 2rem;
        position: relative;
      }

      .preview-toggle {
        position: fixed;
        bottom: 2rem;
        right: 2rem;
        z-index: 10;
        display: none;
      }

      @media (max-width: 1199px) {
        .preview-toggle {
          display: block;
        }
        .create-post-preview {
          display: none;
        }
        .show-preview .create-post-form {
          display: none;
        }
        .show-preview .create-post-preview {
          display: block;
        }
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-label {
        display: block;
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
        color: #2d3748;
      }

      .form-input {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #e2e8f0;
        border-radius: 6px;
        font-size: 1rem;
        transition: border-color 0.2s;
      }

      .form-input:focus {
        border-color: #2c5282;
        outline: none;
      }

      textarea.form-input {
        min-height: 200px;
        resize: vertical;
      }

      .submit-button {
        background-color: #2c5282;
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 6px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        border: none;
        transition: background-color 0.2s;
      }

      .submit-button:hover {
        background-color: #2a4365;
      }
    ",
    ),

    html.div([attribute.class("create-post-page")], [
      html.div([attribute.class("preview-toggle")], [
        html.button(
          [
            attribute.class("submit-button"),
            event.on_click(msg.CreatePostTogglePreview),
          ],
          [
            element.text(case model.create_post_show_preview {
              True -> "View Form"
              False -> "View Preview"
            }),
          ],
        ),
      ]),
      html.div(
        [
          attribute.class(
            "create-post-container"
            <> case model.create_post_show_preview {
              True -> " show-preview"
              False -> ""
            },
          ),
        ],
        [
          html.div([attribute.class("create-post-form")], [
            html.h1(
              [
                // classes.text_3xl(),
                attribute.styles([
                  #("margin-bottom", "2rem"),
                  #("text-align", "center"),
                ]),
              ],
              [element.text("Create New Post")],
            ),

            // Title input
            html.div([attribute.class("form-group")], [
              html.label([attribute.class("form-label")], [
                element.text("Title"),
              ]),
              html.input([
                attribute.class("form-input"),
                attribute.placeholder("Enter event title..."),
                event.on_input(msg.CreatePostUpdateTitle),
                attribute.value(model.create_post_title),
              ]),
            ]),

            // Excerpt input
            html.div([attribute.class("form-group")], [
              html.label([attribute.class("form-label")], [
                element.text("Excerpt"),
              ]),
              html.input([
                attribute.class("form-input"),
                attribute.placeholder("Enter a brief description..."),
                event.on_input(msg.CreatePostUpdateExcerpt),
                attribute.value(model.create_post_excerpt),
              ]),
            ]),

            // Content input
            html.div([attribute.class("form-group")], [
              html.label([attribute.class("form-label")], [
                element.text("Content"),
              ]),
              html.textarea(
                [
                  attribute.class("form-input"),
                  attribute.placeholder(
                    "Enter the full event content in markdown...",
                  ),
                  event.on_input(msg.CreatePostUpdateContent),
                ],
                model.create_post_content,
              ),
            ]),

            // Author input
            // TODO: Add "known authors" table to the db, call and search in a dropdown here.
            html.div([attribute.class("form-group")], [
              html.label([attribute.class("form-label")], [
                element.text("Author"),
              ]),
              html.input([
                attribute.class("form-input"),
                attribute.placeholder("Enter author name..."),
                event.on_input(msg.CreatePostUpdateAuthor),
                attribute.value(model.create_post_author),
              ]),
            ]),

            // Submit button
            // TODO: Add warnings if necessary, and potentially an "are you sure?" confirmation.
            // Check for "title already exists", especially. 
            // WARN: Can't have two identical slugs, could maybe increment.
            html.div(
              [
                attribute.styles([#("text-align", "center")]),
              ],
              [
                html.button(
                  [
                    attribute.class("submit-button"),
                    event.on_click(msg.RequestCreatePost),
                  ],
                  [
                    element.text("Create Post"),
                  ],
                ),
              ],
            ),
          ]),
          html.div([attribute.class("create-post-preview")], [
            html.h1(
              [
                // classes.text_3xl(),
                attribute.styles([
                  #("margin-bottom", "2rem"),
                  #("text-align", "center"),
                ]),
              ],
              [element.text("Post Preview:")],
            ),
            show_preview(model),
          ]),
        ],
      ),
    ]),
  ])
}

pub fn show_post(model: Model) {
  html.div([], [
    case model.show_post {
      Some(_post) ->
        html.div([], [
          case model.auth_user {
            Some(Admin) ->
              html.div([], [
                html.button([event.on_click(msg.RequestDeletePost)], [
                  element.text("delete post"),
                ]),
              ])
            _ -> element.none()
          },
          html.div([], [
            styles.markdown(),
            element.element(
              "markdown",
              [
                attribute.attribute(
                  "dangerous-unescaped-html",
                  model.show_post_html,
                ),
              ],
              [],
            ),
          ]),
        ])
      None ->
        html.div([], [
          html.p(
            [
              attribute.styles([
                #("font-size", "24px"),
                #("color", "red"),
                #("text-align", "center"),
                #("padding", "20px"),
              ]),
            ],
            [element.text("No post found")],
          ),
        ])
    },
  ])
}

pub fn show_preview(model: Model) {
  html.div([], [
    html.div([], [
      styles.markdown(),
      html.h1(
        [
          attribute.styles([
            #("text-align", "center"),
            #("color", "#333"),
            #("font-size", "2em"),
            #("margin", "20px 0"),
          ]),
        ],
        [
          element.text(case model.create_post_title {
            "" -> "[Title]"
            title -> title
          }),
        ],
      ),
      element.element(
        "markdown",
        [
          attribute.attribute(
            "dangerous-unescaped-html",
            model.create_post_preview,
          ),
        ],
        [],
      ),
    ]),
  ])
}
