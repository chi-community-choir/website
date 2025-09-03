import birl.{type Time}
import birl/duration
import gleam/dict.{type Dict}
import gleam/erlang/process.{type Subject}
import gleam/option.{type Option, None, Some}
import gleam/otp/actor
import gleam/otp/static_supervisor
import gleam/otp/supervision
import shared.{type AuthUser}

import gleam/int
import gleam/io

pub type CacheEntry {
  CacheEntry(user_id: Int, role: AuthUser, timestamp: Time)
}

pub type CacheMessage {
  Get(token: String, reply_to: Subject(Option(CacheEntry)))
  Put(token: String, entry: CacheEntry)
  Remove(token: String)
  Clean
}

pub type State {
  State(self: Subject(CacheMessage), cache: Dict(String, CacheEntry))
}

pub fn initialize(
  parent_subject: Subject(Subject(CacheMessage)),
) -> Result(Subject(CacheMessage), Nil) {
  let cache_worker = supervision.worker(fn() { start_cache(parent_subject) })

  let assert Ok(_supervisor) =
    static_supervisor.new(static_supervisor.RestForOne)
    |> static_supervisor.add(cache_worker)
    |> static_supervisor.start

  process.receive(parent_subject, 5000)
}

fn start_cache(
  parent_subject: Subject(Subject(CacheMessage)),
) -> Result(actor.Started(Subject(CacheMessage)), actor.StartError) {
  actor.new_with_initialiser(2000, fn(self_subject) {
    process.send(parent_subject, self_subject)

    process.send_after(self_subject, 10_000, Clean)

    let selector = process.new_selector() |> process.select(self_subject)

    actor.initialised(State(self_subject, dict.new()))
    |> actor.selecting(selector)
    |> actor.returning(self_subject)
    |> Ok
  })
  |> actor.on_message(handle_message)
  |> actor.start
}

pub fn cache_put(
  cache: Subject(CacheMessage),
  token: String,
  user_id: Int,
  is_admin: AuthUser,
) -> Nil {
  actor.send(cache, Put(token, CacheEntry(user_id, is_admin, birl.now())))
}

pub fn cache_get(
  cache: Subject(CacheMessage),
  token: String,
) -> Option(CacheEntry) {
  actor.call(cache, 5000, fn(reply) { Get(token, reply) })
}

pub fn cache_remove(cache: Subject(CacheMessage), token: String) -> Nil {
  actor.send(cache, Remove(token))
}

fn print_entry(token: String, entry: CacheEntry) -> Nil {
  let CacheEntry(id, role, time) = entry
  io.println(
    "CACHE ENTRY-- TOKEN: "
    <> token
    <> "\nID: "
    <> int.to_string(id)
    <> "\nROLE: "
    <> shared.authuser_string(role)
    <> "\nTIMESTAMP: "
    <> birl.to_time_string(time),
  )
}

fn handle_message(
  state: State,
  msg: CacheMessage,
) -> actor.Next(State, CacheMessage) {
  let State(self_subject, cache) = state

  case msg {
    Put(token, entry) -> {
      io.println("inserting entry into cache:")
      print_entry(token, entry)
      actor.continue(State(self_subject, dict.insert(cache, token, entry)))
    }

    Get(token, reply_to) -> {
      case dict.get(cache, token) {
        Ok(entry) -> {
          let CacheEntry(id, role, _) = entry
          io.println("got user id from cache: " <> int.to_string(id))
          let updated = CacheEntry(id, role, birl.now())
          // reply and update timestamp in cache
          process.send(reply_to, Some(updated))
          actor.continue(State(self_subject, dict.insert(cache, token, updated)))
        }
        Error(_) -> {
          io.println("no associated user id found in cache")
          process.send(reply_to, None)
          actor.continue(state)
        }
      }
    }

    Remove(token) -> {
      io.println("removing id from cache associated with token: " <> token)
      actor.continue(State(self_subject, dict.drop(cache, [token])))
    }

    Clean -> {
      // filter out aged entries; keep entries where age < 5 minutes
      let new_cache =
        dict.filter(cache, fn(_token, entry) {
          case entry {
            CacheEntry(id, _, timestamp) -> {
              let diff_ms =
                birl.difference(birl.now(), timestamp)
                |> duration.blur_to(duration.Minute)
              case diff_ms {
                diff if diff >= 5 -> {
                  io.println(
                    "removing entry from cache via cleaner. id: "
                    <> int.to_string(id),
                  )
                  io.println("age: " <> int.to_string(diff) <> " minutes")
                  False
                }
                _ -> True
              }
            }
          }
        })

      // schedule next clean in 60s
      process.send_after(self_subject, 60_000, Clean)
      actor.continue(State(self_subject, new_cache))
    }
  }
}
