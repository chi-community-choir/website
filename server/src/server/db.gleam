import cake.{type ReadQuery, type WriteQuery}
import cake/dialect/sqlite_dialect
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import sqlight.{type Value}

pub fn execute_read(
  read_query: ReadQuery,
  params: List(Value),
  decoder: decode.Decoder(a),
) {
  let prepared_statement =
    read_query
    |> sqlite_dialect.read_query_to_prepared_statement
    |> cake.get_sql
    |> echo

  use conn <- sqlight.with_connection("file:lfs.db")
  sqlight.query(prepared_statement, conn, params, decoder) |> echo
}

pub fn execute_write(write_query: WriteQuery(a), params: List(Value)) {
  let prepared_statement =
    write_query
    |> sqlite_dialect.write_query_to_prepared_statement
    |> cake.get_sql
    |> echo

  use conn <- sqlight.with_connection("file:lfs.db")
  sqlight.query(prepared_statement, conn, params, decode.int) |> echo
}

@external(erlang, "erlang", "list_to_tuple")
pub fn list_to_tuple(dynamic: Dynamic) -> Dynamic

pub fn init() {
  use conn <- sqlight.with_connection("file:lfs.db")

  let assert Ok(Nil) =
    "
    create table if not exists user_session (
      id integer primary key autoincrement,
      user_id integer,
      token text unique not null,
      created_at datetime default current_timestamp,
      foreign key (user_id) references users(id) on delete cascade
    );
  "
    |> sqlight.exec(conn)

  let assert Ok(Nil) =
    "
    create table if not exists users (
      id integer primary key autoincrement,
      username text unique,
      password_hash text,
      display_name text,
      role text check(role in ('admin', 'user')) not null
    );
    "
    |> sqlight.exec(conn)

  let assert Ok(Nil) = // TODO: Switch href for linked table of large file links, in crm
    "
    create table if not exists songs (
      id integer primary key,
      title text not null,
      slug text unique not null,
      href varchar(255),
      created_at datetime default current_timestamp
    );
    "
    
    |> sqlight.exec(conn)

  let assert Ok(Nil) = // TODO: optional pdf instead of content
    "
    create table if not exists posts (
      id integer primary key autoincrement,
      title text not null,
      content text not null,
      excerpt text,
      author text,
      slug text unique not null,
      user_id integer,
      created_at datetime default current_timestamp,
      updated_at datetime default current_timestamp,
      foreign key (user_id) references users(id) on delete set null
    );
    "
    |> sqlight.exec(conn)

}
