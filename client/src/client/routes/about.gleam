import client/lib/model.{type Model}
import lustre/attribute.{alt, class, href, style, src}
import lustre/element.{text}
import lustre/element/html.{a, div, h1, h2, img, p, section}
import lustre/ui/classes
import client/styles

pub fn about(_model: Model) {
  div([
    style([
      #("background-color", "#cecfce"),
      #("display", "flex"),
      #("flex-direction", "column"),
      #("min-height", "100vh"),
      #("padding", "1rem 0"),
      #("margin", "0 auto"),
      // #("max-width", "1100px"), // Slightly wider for larger text
      #("font-size", "20px"), // Base font size increased
      #("line-height", "1.8"), // More generous line height
    ]),
  ], [
    section([class("about-hero")], [
      div([class("container")], [
        div(
          [
            class("hero-content"),
            style([
              #("display", "flex"),
              #("flex-direction", "column"),
              #("align-items", "center"),
              #("padding", "1rem"),
            ]),
          ],
          [
            h1([
              classes.text_4xl(),
              style([
                #("margin-bottom", "2rem"),
                #("font-weight", "bold"),
                #("font-size", "3.5rem"), // Larger heading
                // #("color", "#1a365d"), // Dark blue/grey
                #("letter-spacing", "1px"), // Slightly more spacing between letters
                #("text-shadow", "2px 2px 4px rgba(0,0,0,0.3)"),
              ]),
            ], [text("About Us")]),
          ],
        ),
      ]),
    ]),
    section([class("directors-bio")], [
      div([class("container")], [
        div([
          class("directors-box"),
          styles.aside_wrap(),
        ], [
          div([class("directors-image")], [
            img([
              alt("Directors Caroline and John"), 
              src("https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/Caroline-and-John-1.jpg"),
              styles.img_md(),
              style([
                #("border-radius", "12px"),
                #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.2)"), // Subtle shadow for better distinction
                #("max-width", "100%"),
              ]),
            ]),
          ]),
          div([
            class("directors-info"),
            style([
              #("flex", "1 1 200px"),
              #("max-height", "100%"),
              #("max-width", "600px"),
              #("margin", "0"),
            ]),
          ], [
            h2([
              classes.text_xl(),
              style([
                #("font-size", "2.25rem"),
                #("margin-bottom", "1rem"),
                // #("color", "#1a365d"),
                // #("font-weight", "bold"),
              ]),
            ], [text("Our Directors")]),
            p([
              classes.text_xl(),
              style([
                #("font-size", "1.25rem"),
                #("line-height", "1.8"),
                #("margin-bottom", "1.5rem"),
                #("color", "#2d3748"),
              ]),
            ], [
              text(
                "Both our choir leaders have extensive knowledge & years of experience in building fabulous vocal groups, and vast amounts of enthusiasm to get our local community singing!",
              ),
            ]),
          ]),
        ]),
      ]),
    ]),
    section([
      class("choir-info"),
      style([
        #("padding", "3rem 2rem"),
        #("margin", "2rem 0"),
        #("padding-bottom", "0"),
      ]),
    ], [
      div([
        class("container"),
        style([
          #("max-width", "800px"),
          #("margin", "0 auto"),
        ]),
      ], [
        p([
          style([
            #("margin-bottom", "2rem"),
            #("line-height", "1.8"),
            #("font-size", "1.25rem"), // Larger body text
            #("max-width", "70ch"), // Optimal line length for readability
            #("color", "#2d3748"),
          ]),
        ], [
          text(
            "Meeting every week on Tuesday evenings, we aim to provide singers with the opportunity to explore a wide variety of musical styles. We perform in rich harmony using SATB voice parts: from madrigals to mash-ups, rounds to rock and canons to classical.",
          ),
        ]),
        p([
          styles.aside_wrap(),
          style([
            #("line-height", "1.6"),
            #("color", "#2d3748"),
            #("gap", "0"),
          ]),
        ], [
          text("For details on how to join us, email:"),
          a(
            [
              href("mailto://caroline@chicommunitychoir.com"),
              style([
                #("color", "#2c52FF"),
                #("text-decoration", "underline"),
                #("font-weight", "600"),
                #("padding", "1rem 2rem"), // Larger click target
              ]),
            ],
            [text("caroline@chicommunitychoir.com")],
          ),
        ]),
      ]),
    ]),
    section([
      class("foundation"),
      style([
        #("padding", "3rem 2rem"),
        #("border-top", "1px solid #e2e8f0"),
      ]),
    ], [
      div([
        class("container"),
        style([
          #("max-width", "800px"),
          #("margin", "0 auto"),
        ]),
      ], [
        p([
          style([
            #("line-height", "1.6"),
            #("color", "#2d3748"),
            #("font-size", "1.25rem"), // Larger body text
          ]),
        ], [
          text(
            "Chichester Community Choir was founded by Steve Flashman, who soon realised that not everyone could make it to evening rehearsals. He set up satellite daytime choirs to complement the CCC, which are now run by Caroline as Upbeat Singers, in Southbourne and East Preston. John also runs a daytime choir, the Ok Chorale.",
          ),
        ]),
      ]),
    ]),
  ])
}
