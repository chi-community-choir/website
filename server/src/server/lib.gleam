import gleam/string

pub fn title_to_slug(title: String) -> String {
  title
  |> string.trim()
  |> string.lowercase()
  |> string.replace(" ", "-")
}
