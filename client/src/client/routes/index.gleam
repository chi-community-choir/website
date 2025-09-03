import client/lib/model.{type Model}
import client/styles
import lustre/attribute.{alt, class, src, styles}
import lustre/element.{text}
import lustre/element/html.{a, br, div, h1, h2, img, p, section}

pub fn index(_model: Model) {
  div(
    [
      styles.page_default(),
      styles([
        #("align-items", "center"),
        #("font-size", "18px"),
        #("line-height", "1.8"),
      ]),
    ],
    [
      section([class("banner")], [
        div(
          [
            class("container"),
            styles([
              #("display", "flex"),
              #("justify-content", "center"),
              #("align-items", "center"),
            ]),
          ],
          [
            img([
              alt("banner image"),
              src(
                "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/2019-12-13-Choir-Header-1.png",
              ),
              // 1280x325
              styles([
                #("border-radius", "8px"),
                #("max-width", "90%"),
                #("height", "auto"),
                #("box-shadow", "0 2px 4px rgba(0,0,0,0.1)"),
                // Subtle shadow
              ]),
            ]),
          ],
        ),
      ]),
      section([class("welcome")], [
        div(
          [
            styles([
              #("max-width", "900px"),
              #("margin", "0 auto 3rem"),
              #("padding", "2rem"),
              #("background-color", "#f8fafc"),
              #("border-radius", "12px"),
              #("text-align", "center"),
            ]),
          ],
          [
            h1(
              [
                styles([
                  #("color", "#1a365d"),
                  #("font-size", "2.5rem"),
                  #("margin-bottom", "1.5rem"),
                  #("font-weight", "bold"),
                ]),
              ],
              [text("Welcome to Chichester Community Choir")],
            ),
            p(
              [
                styles([
                  #("font-size", "1.25rem"),
                  #("color", "#2d3748"),
                  #("margin-bottom", "1.5rem"),
                ]),
              ],
              [
                text(
                  "Join us in the joy of singing! No auditions required - just bring your enthusiasm and love for music.",
                ),
              ],
            ),
          ],
        ),
      ]),
      section([class("info-boxes")], [
        div(
          [
            styles([
              #("display", "grid"),
              #("grid-template-columns", "repeat(auto-fit, minmax(280px, 1fr))"),
              #("gap", "2rem"),
              #("max-width", "1100px"),
              #("margin", "0 auto 3rem"),
              #("padding", "0 1rem"),
            ]),
          ],
          [
            // Next Rehearsal Box
            div(
              [
                styles([
                  #("background-color", "#ffffff"),
                  #("border", "2px solid #e2e8f0"),
                  #("border-radius", "12px"),
                  #("padding", "1.5rem"),
                  #("text-align", "center"),
                ]),
              ],
              [
                h2(
                  [
                    styles([
                      #("color", "#1a365d"),
                      #("font-size", "1.5rem"),
                      #("margin-bottom", "1rem"),
                      #("font-weight", "bold"),
                    ]),
                  ],
                  [text("Next Rehearsal")],
                ),
                p([styles([#("font-size", "1.25rem"), #("color", "#2d3748")])], [
                  text("Every Tuesday"),
                  br([]),
                  text("7:30 PM - 9:30 PM"),
                  br([]),
                  text("University of Chichester"),
                  br([]),
                  a(
                    [
                      attribute.href("/find-us"),
                      styles([
                        #("display", "inline-block"),
                        #("background-color", "#2c5282"),
                        #("color", "#ffffff"),
                        #("padding", "0.75rem 1.5rem"),
                        #("border-radius", "8px"),
                        #("font-size", "1.2rem"),
                        #("text-decoration", "none"),
                        #("margin-top", "1rem"),
                        #("transition", "background-color 0.2s ease"),
                        #("&:hover", "background-color: #2a4365"),
                      ]),
                    ],
                    [text("Find Us")],
                  ),
                ]),
              ],
            ),
            // Join Us Box
            div(
              [
                styles([
                  #("background-color", "#ffffff"),
                  #("border", "2px solid #e2e8f0"),
                  #("border-radius", "12px"),
                  #("padding", "1.5rem"),
                  #("text-align", "center"),
                ]),
              ],
              [
                h2(
                  [
                    styles([
                      #("color", "#1a365d"),
                      #("font-size", "1.5rem"),
                      #("margin-bottom", "1rem"),
                      #("font-weight", "bold"),
                    ]),
                  ],
                  [text("Want to Join?")],
                ),
                p(
                  [
                    styles([
                      #("font-size", "1.25rem"),
                      #("color", "#2d3748"),
                      #("margin-bottom", "1rem"),
                    ]),
                  ],
                  [
                    text(
                      "Your first session is free! Come along and give it a try.",
                    ),
                  ],
                ),
                a(
                  [
                    attribute.href("mailto:caroline@chicommunitychoir.com"),
                    styles([
                      #("display", "inline-block"),
                      #("background-color", "#2c5282"),
                      #("color", "#ffffff"),
                      #("padding", "0.75rem 1.5rem"),
                      #("border-radius", "8px"),
                      #("font-size", "1.2rem"),
                      #("text-decoration", "none"),
                      #("margin-top", "0.5rem"),
                      #("transition", "background-color 0.2s ease"),
                      #("&:hover", "background-color: #2a4365"),
                    ]),
                  ],
                  [text("Contact Us to Join")],
                ),
              ],
            ),
            // Next Performance Box
            div(
              [
                styles([
                  #("background-color", "#ffffff"),
                  #("border", "2px solid #e2e8f0"),
                  #("border-radius", "12px"),
                  #("padding", "1.5rem"),
                  #("text-align", "center"),
                ]),
              ],
              [
                h2(
                  [
                    styles([
                      #("color", "#1a365d"),
                      #("font-size", "1.5rem"),
                      #("margin-bottom", "1rem"),
                      #("font-weight", "bold"),
                    ]),
                  ],
                  [text("Latest News")],
                ),
                p([styles([#("font-size", "1.25rem"), #("color", "#2d3748")])], [
                  text("Stay tuned for upcoming performances and events!"),
                ]),
              ],
            ),
          ],
        ),
      ]),
      section([class("CTA-bottom")], [
        div(
          [
            styles([
              #("background-color", "#f0f4f8"),
              #("padding", "2rem"),
              #("text-align", "center"),
              #("border-radius", "12px"),
              #("max-width", "900px"),
              #("margin", "0 auto 3rem"),
            ]),
          ],
          [
            h2(
              [
                styles([
                  #("color", "#1a365d"),
                  #("font-size", "1.8rem"),
                  #("margin-bottom", "1rem"),
                  #("font-weight", "bold"),
                ]),
              ],
              [text("Come Sing With Us!")],
            ),
            p(
              [
                styles([
                  #("font-size", "1.25rem"),
                  #("color", "#2d3748"),
                  #("margin-bottom", "1.5rem"),
                  #("max-width", "600px"),
                  #("margin-left", "auto"),
                  #("margin-right", "auto"),
                ]),
              ],
              [
                text(
                  "Experience the joy of singing together in a friendly, welcoming environment. No previous experience needed!",
                ),
              ],
            ),
          ],
        ),
      ]),
    ],
  )
}
