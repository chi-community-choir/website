import gleam/dynamic/decode
import cake/select
import gleam/list
import gleam/order.{type Order}
import gleam/string
import server/db
import sqlight

pub type Migration(a) {
  Migration(name: String, query: String)
}

pub fn init() {
  use conn <- sqlight.with_connection("file:lfs.db")

  let assert Ok(Nil) =
"
create table if not exists schema_migrations (
  id integer primary key autoincrement,
  name text unique not null,
  applied_at datetime default current_timestamp
);
" |> sqlight.exec(conn)

  run_migrations()
}

fn run_migrations() {
  let sorted = migrations() |> list.sort(compare_migrations)
  let assert Ok(completed_migrations) = select.new()
  |> select.select(select.col("schema_migrations.name"))
  |> select.from_table("schema_migrations")
  |> select.to_query
  |> db.execute_read([], {
    use names <- decode.field(0, decode.string)
    decode.success(names)
    }
  )
  echo "Previously completed migrations:"
  echo completed_migrations

  {
    use conn <- sqlight.with_connection("file:lfs.db")
    use migration <- list.each(sorted)

    case list.contains(completed_migrations, migration.name) {
      False -> {
        let assert Ok(Nil) = migration.query |> sqlight.exec(conn)
        let assert Ok(Nil) = {"insert into schema_migrations(name) values ('"<>migration.name<>"')"} |> sqlight.exec(conn)
        {"Migration performed: " <> migration.name} |> echo
      }
      _ -> {
        {"Migration skipped: " <> migration.name}
      }
    }
  }

  "Migration complete." |> echo
}

fn compare_migrations(first: Migration(a), second: Migration(a)) -> Order {
  string.compare(first.name, second.name)
}

fn migrations() -> List(Migration(a)) {
  [
    Migration(
      name: "001_create_users",
      query: "
create table if not exists users (
  id integer primary key autoincrement,
  username text unique not null,
  password text not null,
  display_name text,
  role text check(role in ('admin', 'user')) not null
);
",
    ),
    Migration(
      name: "002_create_sessions",
      query: "
create table if not exists sessions (
  id integer primary key autoincrement,
  user_id integer,
  token text unique not null,
  created_at datetime default current_timestamp,
  foreign key (user_id) references users(id) on delete cascade
);
",
    ),
    Migration( // TODO: Switch href for linked table of large file links, in crm
      name: "003_create_songs",
      query: "
create table if not exists songs (
  id integer primary key autoincrement,
  title text not null,
  slug text unique not null,
  href varchar(255),
  created_at datetime default current_timestamp
);
",
    ),
    Migration( // TODO: optional pdf instead of content
      name: "004_create_posts",
      query: "
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
",
    ),
  ]
}
