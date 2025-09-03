import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import client/styles
import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html

pub fn about(_model: Model) -> Element(Msg) {
  html.div(
    [
      styles.page_default(),
      attribute.styles([
        #("background-color", "#f5f5f5"),
        #("font-size", "20px"),
        #("line-height", "1.6"),
      ]),
    ],
    [
      // Hero section
      html.section(
        [
          attribute.styles([
            #("background-color", "#2c5282"),
            #("color", "white"),
            #("padding", "3rem 1rem"),
            #("text-align", "center"),
            #("margin-bottom", "2rem"),
          ]),
        ],
        [
          html.h1(
            [
              attribute.styles([
                #("font-size", "3rem"),
                #("margin-bottom", "1rem"),
              ]),
            ],
            [text("About Us")],
          ),
          html.p(
            [
              attribute.styles([
                #("max-width", "800px"),
                #("margin", "0 auto"),
                #("font-size", "1.2rem"),
              ]),
            ],
            [
              text(
                "Learn about the Chichester Community Choir, our directors, and our mission to bring people together through music.",
              ),
            ],
          ),
        ],
      ),
      // Directors section
      html.section(
        [
          attribute.styles([
            #("max-width", "1200px"),
            #("margin", "0 auto 3rem auto"),
            #("padding", "2rem"),
            #("background-color", "white"),
            #("border-radius", "8px"),
            #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
          ]),
        ],
        [
          html.h2(
            [
              attribute.styles([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [text("Our Directors")],
          ),
          html.div([styles.aside_wrap()], [
            // Directors image
            html.div(
              [
                attribute.styles([#("flex", "1 1 3rem"), #("min-width", "300px")]),
              ],
              [
                html.img([
                  attribute.alt("Directors Caroline and John"),
                  attribute.src(
                    "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/Caroline-and-John-1.jpg",
                  ),
                  attribute.styles([
                    #("max-width", "100%"),
                    #("height", "auto"),
                    #("max-height", "400px"),
                    #("object-fit", "contain"),
                    #("border-radius", "8px"),
                    #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
                  ]),
                ]),
              ],
            ),
            // Directors information
            html.div(
              [attribute.styles([#("flex", "1 1 400px"), #("padding", "1rem")])],
              [
                html.p(
                  [
                    attribute.styles([
                      #("margin-bottom", "1.5rem"),
                      #("font-size", "1.1rem"),
                    ]),
                  ],
                  [
                    text(
                      "Both our choir leaders have extensive knowledge and years of experience in building fabulous vocal groups, and vast amounts of enthusiasm to get our local community singing!",
                    ),
                  ],
                ),
                html.p(
                  [
                    attribute.styles([
                      #("margin-bottom", "1.5rem"),
                      #("font-size", "1.1rem"),
                    ]),
                  ],
                  [
                    text(
                      "Caroline and John bring a blend of classical training and contemporary approaches to choral direction, creating an inclusive and dynamic environment for singers of all levels.",
                    ),
                  ],
                ),
                html.p([attribute.styles([#("font-size", "1.1rem")])], [
                  text(
                    "With backgrounds in music education and performance, they specialize in helping choir members develop their vocal skills while fostering a strong sense of community and enjoyment.",
                  ),
                ]),
              ],
            ),
          ]),
        ],
      ),
      // Choir information section
      html.section(
        [
          attribute.styles([
            #("max-width", "1200px"),
            #("margin", "0 auto 3rem auto"),
            #("padding", "2rem"),
            #("background-color", "white"),
            #("border-radius", "8px"),
            #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
          ]),
        ],
        [
          html.h2(
            [
              attribute.styles([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [text("Our Choir")],
          ),
          html.div(
            [attribute.styles([#("max-width", "900px"), #("margin", "0 auto")])],
            [
              html.p(
                [
                  attribute.styles([
                    #("margin-bottom", "1.5rem"),
                    #("font-size", "1.1rem"),
                    #("text-align", "center"),
                  ]),
                ],
                [
                  text(
                    "Meeting every Tuesday evening from 7:30 PM to 9:30 PM, we provide singers with the opportunity to explore a wide variety of musical styles. We perform in rich harmony using SATB voice parts: from madrigals to mash-ups, rounds to rock and canons to classical.",
                  ),
                ],
              ),
              html.div(
                [
                  attribute.styles([
                    #("display", "flex"),
                    #("flex-wrap", "wrap"),
                    #("gap", "2rem"),
                    #("justify-content", "center"),
                    #("margin-top", "2rem"),
                  ]),
                ],
                [
                  choir_feature(
                    "Inclusive Environment",
                    "We welcome singers of all abilities, from beginners to experienced performers, in a supportive atmosphere.",
                  ),
                  choir_feature(
                    "Diverse Repertoire",
                    "Our performances span multiple genres and eras, ensuring there's something for everyone to enjoy.",
                  ),
                  choir_feature(
                    "Community Focused",
                    "Beyond making music, we build connections and friendships within our local community.",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Rehearsal information
      html.section(
        [
          attribute.styles([
            #("max-width", "1200px"),
            #("margin", "0 auto 3rem auto"),
            #("padding", "2rem"),
            #("background-color", "white"),
            #("border-radius", "8px"),
            #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
          ]),
        ],
        [
          html.h2(
            [
              attribute.styles([
                #("font-size", "2rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [text("Rehearsal Information")],
          ),
          html.div([styles.aside_wrap()], [
            // Rehearsal details
            html.div(
              [
                attribute.styles([
                  #("flex", "1 1 400px"),
                  #("padding", "2rem"),
                  #("background-color", "rgba(255, 255, 255, 0.7)"),
                  #("border-radius", "8px"),
                  #("margin", "1rem"),
                ]),
              ],
              [
                html.h3(
                  [
                    attribute.styles([
                      #("font-size", "1.5rem"),
                      #("margin-bottom", "1rem"),
                      #("color", "#2c5282"),
                    ]),
                  ],
                  [text("When & Where")],
                ),
                html.p([attribute.styles([#("margin-bottom", "1rem")])], [
                  text("Tuesday Evenings"),
                  html.br([]),
                  text("7:30 PM - 9:30 PM"),
                ]),
                html.p([attribute.styles([#("margin-bottom", "1.5rem")])], [
                  text("University of Chichester"),
                  html.br([]),
                  text("College Ln"),
                  html.br([]),
                  text("PO19 6PF"),
                ]),
                html.p([], [
                  text("For details on how to join us, email: "),
                  html.a(
                    [
                      attribute.href("mailto:caroline@chicommunitychoir.com"),
                      attribute.styles([
                        #("color", "#2c5282"),
                        #("font-weight", "600"),
                        #("text-decoration", "underline"),
                      ]),
                    ],
                    [text("caroline@chicommunitychoir.com")],
                  ),
                ]),
              ],
            ),
            // What to expect
            html.div(
              [
                attribute.styles([
                  #("flex", "1 1 400px"),
                  #("padding", "2rem"),
                  #("background-color", "rgba(255, 255, 255, 0.7)"),
                  #("border-radius", "8px"),
                  #("margin", "1rem"),
                ]),
              ],
              [
                html.h3(
                  [
                    attribute.styles([
                      #("font-size", "1.5rem"),
                      #("margin-bottom", "1rem"),
                      #("color", "#2c5282"),
                    ]),
                  ],
                  [text("What to Expect")],
                ),
                html.ul(
                  [
                    attribute.styles([
                      #("list-style-type", "disc"),
                      #("padding-left", "1.5rem"),
                    ]),
                  ],
                  [
                    html.li([attribute.styles([#("margin-bottom", "0.5rem")])], [
                      text("Warm-up exercises to prepare your voice"),
                    ]),
                    html.li([attribute.styles([#("margin-bottom", "0.5rem")])], [
                      text("Section practice for each voice part"),
                    ]),
                    html.li([attribute.styles([#("margin-bottom", "0.5rem")])], [
                      text("Full ensemble work on current repertoire"),
                    ]),
                    html.li([attribute.styles([#("margin-bottom", "0.5rem")])], [
                      text("A mix of sight-reading and learning by ear"),
                    ]),
                    html.li([], [text("Plenty of laughter and enjoyment!")]),
                  ],
                ),
              ],
            ),
          ]),
        ],
      ),
      // History section
      html.section(
        [
          attribute.styles([
            #("max-width", "1200px"),
            #("margin", "0 auto 3rem auto"),
            #("padding", "2rem"),
            #("background-color", "white"),
            #("border-radius", "8px"),
            #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
          ]),
        ],
        [
          html.h2(
            [
              attribute.styles([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [text("Our History")],
          ),
          html.div(
            [attribute.styles([#("max-width", "800px"), #("margin", "0 auto")])],
            [
              html.p(
                [
                  attribute.styles([
                    #("margin-bottom", "1.5rem"),
                    #("font-size", "1.1rem"),
                    #("text-align", "center"),
                  ]),
                ],
                [
                  text(
                    "Chichester Community Choir was founded by Steve Flashman, who soon realised that not everyone could make it to evening rehearsals. He set up satellite daytime choirs to complement the CCC, which are now run by Caroline as Upbeat Singers, in Southbourne and East Preston. John also runs a daytime choir, the Ok Chorale.",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Join us call to action
      html.section(
        [
          attribute.styles([
            #("background-color", "#1a365d"),
            #("color", "white"),
            #("padding", "3rem 1rem"),
            #("text-align", "center"),
          ]),
        ],
        [
          html.h2(
            [
              attribute.styles([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
              ]),
            ],
            [text("Join Our Choir Family")],
          ),
          html.p(
            [
              attribute.styles([
                #("max-width", "600px"),
                #("margin", "0 auto 1.5rem auto"),
                #("font-size", "1.2rem"),
              ]),
            ],
            [
              text(
                "No auditions required! We welcome singers of all experience levels who share our passion for music and community.",
              ),
            ],
          ),
          html.a(
            [
              attribute.href("membership"),
              attribute.styles([
                #("display", "inline-block"),
                #("background-color", "white"),
                #("color", "#1a365d"),
                #("font-weight", "bold"),
                #("padding", "1rem 2rem"),
                #("border-radius", "4px"),
                #("text-decoration", "none"),
                #("font-size", "1.2rem"),
                #("margin-top", "1rem"),
                #("transition", "background-color 0.3s, transform 0.3s"),
                #(
                  "&:hover",
                  "background-color: #f0f4f8; transform: translateY(-2px)",
                ),
              ]),
            ],
            [text("Learn About Membership")],
          ),
        ],
      ),
    ],
  )
}

fn choir_feature(title: String, description: String) -> Element(Msg) {
  html.div(
    [
      attribute.styles([
        #("background-color", "#f8fafc"),
        #("border-radius", "8px"),
        #("padding", "1.5rem"),
        #("box-shadow", "0 2px 4px rgba(0, 0, 0, 0.05)"),
        #("width", "250px"),
        #("max-width", "100%"),
      ]),
    ],
    [
      html.h3(
        [
          attribute.styles([
            #("color", "#2c5282"),
            #("font-size", "1.3rem"),
            #("margin-bottom", "0.75rem"),
            #("text-align", "center"),
          ]),
        ],
        [text(title)],
      ),
      html.p(
        [
          attribute.styles([
            #("color", "#4a5568"),
            #("text-align", "center"),
            #("margin", "0"),
          ]),
        ],
        [text(description)],
      ),
    ],
  )
}
