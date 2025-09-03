import client/lib/decoder
import gleam/io
import gleam/bool
import gleam/json
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}

import client/lib
import client/lib/model.{type Model, Model, TestModel}
import client/lib/msg.{type Msg}
import client/lib/route
import client/routes/app
import client/routes/auth

import plinth/browser/document
import plinth/browser/element as browser_element

import shared.{User, Admin}

pub fn main() {
  let assert Ok(json_string) =
    document.query_selector("#model")
    |> result.map(browser_element.inner_text)

  io.println(json_string)

  // maybe split whole model parsing up into routes? idk

  let initial_model = case json.parse(json_string, decoder.model_decoder()) {
    Ok(model) -> model
    Error(err) -> {
      case err {
        json.UnexpectedEndOfInput -> io.println("json.UnexpectedEndOfInput")
        json.UnableToDecode(err_list) -> {
          io.println("json.UnableToDecode")
          err_list
          |> list.each(fn(err) {
            io.println("Decode error:")
            io.println("Path: " <> err.path |> string.join(", "))
            io.println("Expected: " <> err.expected)
            io.println("Found: " <> err.found)
          })
        }
        _ -> io.println("other error")
      }
      Model(
        test_model: TestModel(counter: 1),
        route: route.get_route(),
        create_song_title: "",
        create_song_href: "",
        create_song_error: None,
        create_post_title: "",
        create_post_content: "",
        create_post_excerpt: "",
        create_post_author: "",
        create_post_slug: "",
        create_post_preview: "",
        create_post_show_preview: False,
        create_post_error: None,
        delete_post_error: None,
        login_username: "",
        login_password: "",
        login_error: None,
        auth_user: None,
        admin_username: "",
        songs: [],
        posts: [],
        posts_search_bar: "",
        show_song: None,
        show_post: None,
        show_post_html: "",
      )
    }
  }

  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", initial_model)

  Nil
}

fn init(model: Model) -> #(_, Effect(Msg)) {
  #(
    model,
    effect.batch([
      lib.get_auth_user(),
      case route.get_route() {
        route.ShowPost(_) -> case model.show_post {
          Some(post) -> {
            effect.from(fn(dispatch) {
              dispatch(msg.RenderPost(post.content))
            })
          }
          None -> effect.none()
        }
        _ -> effect.none()
      },
    ])
  )
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    msg.TestIncrement -> #(
      Model(..model, test_model: TestModel(..model.test_model, counter: model.test_model.counter + 1)),
      effect.none()
    )
    msg.OnRouteChange(route) -> #(
      Model(..model, route: route),
      case route {
        route.ShowSong(_) -> lib.get_show_song()
        route.ShowPost(_) -> {
          effect.batch([
            lib.get_show_post(),
            case model.show_post {
              Some(post) -> {
                effect.from(fn(dispatch) {
                  dispatch(msg.RenderPost(post.content))
                })
              }
              None -> effect.none()
            }
          ])
        }
        //  TODO: tags
        _ -> effect.none()
      },
    )
    msg.AuthUserReceived(auth_user_result) ->
      case auth_user_result {
        Ok(auth_user) -> #(Model(..model, auth_user: Some(auth_user)), case
          model.route
        {
          // admin route options maybe
          _ -> effect.batch([])
        })
        Error(_) -> {
          #(model, effect.none())
        }
      }
    msg.SongsReceived(get_songs_result) -> {
      case get_songs_result {
        Ok(get_songs) -> #(
          Model(..model, songs: get_songs.songs),
          effect.none(),
        )
        Error(_) -> #(model, effect.none())
      }
    }
    msg.PostsReceived(get_posts_result) -> {
      case get_posts_result {
        Ok(get_posts) -> #(
          Model(..model, posts: get_posts.posts),
          effect.none(),
        )
        Error(_) -> #(model, effect.none())
      }
    }
    msg.PostUpdateSearchBar(value) -> {
      #(
        Model(..model, posts_search_bar: value),
        effect.none(),
      )
    }
    msg.ShowSongReceived(get_song_result) -> {
      case get_song_result {
        Ok(get_song) -> #(
          Model(..model, show_song: Some(get_song)),
          effect.none(),
        )
        Error(_) -> #(model, effect.none())
      }
    }
    msg.ShowPostReceived(get_post_result) -> {
      case get_post_result {
        Ok(get_post) -> #(
          Model(..model, show_post: Some(get_post)),
          effect.none(),
        )
        Error(_) -> #(model, effect.none())
      }
    }
    msg.RenderPost(content) -> {
      #(model, lib.render_post(content))
    }
    msg.PostRendered(html_content) -> {
      #(
        Model(..model, show_post_html: html_content),
        effect.none(),
      )
    }
    msg.LoginUpdateUsername(value) -> #(
      Model(..model, login_username: value),
      effect.none(),
    )
    msg.LoginUpdatePassword(value) -> #(
      Model(..model, login_password: value),
      effect.none(),
    )
    msg.LoginUpdateError(value) -> #(
      Model(..model, login_error: value),
      effect.none(),
    )
    msg.RequestLogin(as_admin) -> #(
      model, 
      case as_admin {
        True -> auth.admin_login(model)
        False -> auth.login(model)
      }
    )
    msg.LoginResponded(resp_result) -> {
      case resp_result {
        Ok(resp) -> {
          case resp.error {
            Some(err) -> #(
              model,
              effect.from(fn(dispatch) {
                dispatch(msg.LoginUpdateError(Some(err)))
              }),
            )
            None -> #(
              Model(
                ..model,
                auth_user: Some(User),
                login_password: "",
                login_error: None,
              ),
              effect.batch([
                // TODO: Things that happen when you successfully login
                lib.get_auth_user(),
                // lib.reload_logged_in(),
                // OR lib.server_reload()
              ]),
            )
          }
        }
        Error(_) -> #(
          model,
          effect.from(fn(dispatch) {
            dispatch(msg.LoginUpdateError(Some("HTTP error")))
          }),
        )
      }
    }
    msg.RequestLogout -> #(model, auth.logout(model))
    msg.LogoutResponded(_) -> #(
      Model(..model, auth_user: None),
      effect.batch([lib.get_auth_user()]),
    )

    // Dev-only auth state toggle handlers
    msg.ToggleAuthState -> {
      case model.auth_user {
        Some(_) -> #(Model(..model, auth_user: None), effect.none())
        None -> #(
          Model(..model, auth_user: Some(User)),
          effect.none(),
        )
      }
    }
    msg.ToggleAdminStatus -> {
      case model.auth_user {
        Some(Admin) -> #(
          Model(..model, auth_user: Some(User)),
          effect.none(),
        )
        _ -> #(
          Model(..model, auth_user: Some(Admin)),
          effect.none(),
        )
      }
    }
    msg.CreateSongUpdateTitle(value) -> #(
      Model(..model, create_song_title: value),
      effect.none(),
    )
    msg.CreateSongUpdateHref(value) -> #(
      Model(..model, create_song_href: value),
      effect.none(),
    )
    msg.CreateSongUpdateError(value) -> #(
      Model(..model, create_song_error: value),
      effect.none(),
    )
    msg.RequestCreateSong -> #(model, lib.create_song(model))
    msg.CreateSongResponded(resp_result) -> {
      case resp_result {
        Ok(resp) -> {
          case resp.error {
            Some(err) -> #(
              model,
              effect.from(fn(dispatch) {
                dispatch(msg.CreateSongUpdateError(Some(err)))
              }),
            )
            None -> #(
              Model(
                ..model,
                create_song_title: "",
                create_song_href: "",
                create_song_error: None,
              ),
              effect.batch([lib.get_songs()]),
            )
          }
        }
        Error(_) -> #(
          model,
          effect.from(fn(dispatch) {
            dispatch(msg.CreateSongUpdateError(Some("HTTP Error")))
          }),
        )
      }
    }
    msg.CreatePostUpdateTitle(value) -> #(
      Model(..model, create_post_title: value),
      effect.none(),
    )
    msg.CreatePostUpdateContent(value) -> #(
      Model(..model, create_post_content: value),
      effect.from(fn(dispatch) {
        dispatch(msg.CreatePostRenderPreview)
      }),
    )
    msg.CreatePostUpdateExcerpt(value) -> #(
      Model(..model, create_post_excerpt: value),
      effect.none(),
    )
    msg.CreatePostUpdateAuthor(value) -> #(
      Model(..model, create_post_author: value),
      effect.none(),
    )
    msg.CreatePostRenderPreview -> {
      #(model, lib.render_preview(model.create_post_content))
    }
    msg.CreatePostPreviewRendered(html_content) -> {
      #(
        Model(..model, create_post_preview: html_content),
        effect.none(),
      )
    }
    msg.CreatePostTogglePreview -> {
      #(
        Model(..model, create_post_show_preview: bool.negate(model.create_post_show_preview)),
        effect.none(),
      )
    }
    msg.CreatePostUpdateError(value) -> #(
      Model(..model, create_post_error: value),
      effect.none(),
    )
    msg.RequestCreatePost -> {
      #(model, lib.create_post(model))
    }
    msg.CreatePostResponded(resp_result) -> {
      case resp_result {
        Ok(resp) -> {
          case resp.error {
            Some(err) -> {
              #(
                model,
                effect.from(fn(dispatch) {
                  dispatch(msg.CreatePostUpdateError(Some(err)))
                }),
              )
            }
            None -> {
              #(
                Model(
                  ..model,
                  route: route.Events,
                  create_post_title: "",
                  create_post_content: "",
                  create_post_excerpt: "",
                  create_post_author: "",
                  create_post_error: None,
                ),
                effect.batch([
                  lib.get_posts(),
                  // TODO: change route to "posts", or do some kind of alert?
                ]),
              )
            }
          }
        }
        Error(_) -> {
          #(
            model,
            effect.from(fn(dispatch) {
              dispatch(msg.CreatePostUpdateError(Some("HTTP Error")))
            }),
          )
        }
      }
    }
    msg.RequestDeletePost -> {
      #(model, lib.delete_post(model))
    }
    msg.DeletePostNoSlug -> {
      #(model, effect.none()) // TODO: This should do something
    }
    msg.DeletePostError(value) -> {
      #(Model(..model, delete_post_error: value), effect.none())
    }
    msg.DeletePostResponded(resp_result) -> {
      case resp_result {
        Ok(resp) -> {
          case resp.error {
            Some(err) -> {
              #(
                model,
                effect.from(fn(dispatch) {
                  dispatch(msg.DeletePostError(Some(err)))
                }),
              )
            }
            None -> {
              #(
                Model(
                  ..model,
                  route: route.Events,
                ),
                effect.batch([
                  lib.get_posts(),
                  // TODO: change route to "posts", or do some kind of alert?
                ]),
              )
            }
          }
        }
        Error(_) -> {
          #(
            model,
            effect.from(fn(dispatch) {
              dispatch(msg.CreatePostUpdateError(Some("HTTP Error")))
            }),
          )
        }
      }
    }
  }
}

pub fn view(model: Model) -> Element(Msg) {
  app.app(model)
}
