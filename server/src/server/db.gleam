import cake.{type ReadQuery, type WriteQuery}
import cake/dialect/sqlite_dialect
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
  sqlight.query(prepared_statement, conn, params, decoder)
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
