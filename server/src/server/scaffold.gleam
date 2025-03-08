import lustre/attribute.{attribute, href, name, rel, src}
import lustre/element
import lustre/element/html.{body, head, html, div, link, meta, script, title}

pub fn page_scaffold(
  content: element.Element(a),
  init_json: String,
) {
  html([], [
    head([], [
      meta([attribute("charset", "UTF-8")]),
      meta([
        attribute("content", "width=device-width, initial-scale=1.0"),
        name("viewport"),
      ]),
      title([], "Chichester Community Choir"),
      meta([
        attribute("content", "Official Home of the Chichester Community Choir"),
        name("description"),
      ]),
      meta([attribute("content", "max-image-preview:large"), name("robots")]),
      meta([attribute("content", "en_US"), attribute("property", "og:locale")]),
      meta([
        attribute("content", "Chichester Community Choir"),
        attribute("property", "og:site_name"),
      ]),
      meta([attribute("content", "website"), attribute("property", "og:type")]),
      meta([
        attribute("content", "Chichester Community Choir"),
        attribute("property", "og:title"),
      ]),
      meta([
        attribute("content", "Official Home of the Chichester Community Choir"),
        attribute("property", "og:description"),
      ]),
      meta([attribute("content", ""), attribute("property", "og:url")]),
      meta([
        attribute("content", "Official Home of the Chichester Community Choir"),
        name("twitter:description"),
      ]),
      link([
        href("/priv/static/favicon.ico"), // TODO: Replace with crm favicon link
        attribute.type_("image/x-icon"),
        rel("icon"),
      ]),
      // WARN: Minify when deploying to prod
      script([src("/static/client.mjs"), attribute.type_("module")], ""),
      script([attribute.type_("application/json"), attribute.id("model")], init_json)
      // TODO: Custom CSS
    // link([href("/static/client.min.css"), rel("stylesheet")]),
    // TODO: Custom JS
    // script(
    //   [
    //     src("https://lustre_fullstack.example/js/script.js"),
    //     attribute("data-domain", "lustre_fullstack.example"),
    //     attribute("defer", ""),
    //   ],
    //   "",
    // ),
    ]),
    body([], [
      div([attribute.id("app")], [content]),
    ]),
  ])
}
