import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import client/styles
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn find_us(_model: Model) -> Element(Msg) {
  html.div(
    [
      styles.page_default(),
      attribute.style([
        #("background-color", "#f5f5f5"),
        #("font-size", "20px"),
        #("line-height", "1.6"),
      ]),
    ],
    [
      // Hero section
      html.section(
        [
          attribute.style([
            #("background-color", "#2c5282"),
            #("color", "white"),
            #("padding", "3rem 0"),
            #("text-align", "center"),
            #("margin-bottom", "2rem"),
          ]),
        ],
        [
          html.h1(
            [
              attribute.style([
                #("font-size", "3rem"),
                #("margin-bottom", "1rem"),
              ]),
            ],
            [element.text("Find Us")],
          ),
          html.p(
            [
              attribute.style([
                #("max-width", "800px"),
                #("margin", "0 auto"),
                #("font-size", "1.2rem"),
              ]),
            ],
            [
              element.text(
                "Join us for rehearsals! Here's where you can find the Chichester Community Choir.",
              ),
            ],
          ),
        ],
      ),
      // Location section
      html.section(
        [
          attribute.style([
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
              attribute.style([
                #("font-size", "2rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [element.text("Rehearsal Location")],
          ),
          html.div([styles.aside_wrap()], [
            // Map embed
            html.div(
              [
                attribute.style([
                  #("flex", "1 1 400px"),
                  #("min-width", "300px"),
                ]),
              ],
              [
                html.div(
                  [
                    attribute.style([
                      #("background-color", "#e2e8f0"),
                      #("border-radius", "8px"),
                      #("height", "350px"),
                      #("display", "flex"),
                      #("align-items", "center"),
                      #("justify-content", "center"),
                      #("margin-bottom", "1rem"),
                    ]),
                  ],
                  [
                    html.iframe([
                      attribute.src(
                        "https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1497.9585302692021!2d-0.7732953214085532!3d50.84494506711625!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48744d7d47c733ab%3A0x4fe7a9a44e3150fc!2sUniversity%20of%20Chichester!5e0!3m2!1sen!2suk!4v1740943878324!5m2!1sen!2suk",
                      ),
                      attribute.width(600),
                      attribute.height(450),
                      attribute.style([
                        #("border", "0"),
                        #("allowfullscreen", ""),
                        #("loading", "lazy"),
                        #("referrerpolicy", "no-referrer-when-downgrade"),
                      ]),
                    ]),
                  ],
                ),
              ],
            ),
            // Address information
            html.div(
              [attribute.style([#("flex", "1 1 400px"), #("padding", "1rem")])],
              [
                html.h3(
                  [
                    attribute.style([
                      #("font-size", "1.5rem"),
                      #("color", "#2c5282"),
                    ]),
                  ],
                  [element.text("University of Chichester")],
                ),
                html.p([], [element.text("College Ln, Chichester, PO19 6PF")]),
                html.p([attribute.style([#("margin-top", "1rem")])], [
                  element.text(
                    "We rehearse every Tuesday evening from 6:45 PM to 8:15 PM in the cloisters at the University of Chichester. The building is accessible via public transit, with parking also available on the university grounds.",
                  ),
                ]),
                html.div([attribute.style([#("margin-top", "1.5rem")])], [
                  html.h4(
                    [
                      attribute.style([
                        #("font-size", "1.2rem"),
                        #("margin-bottom", "0.5rem"),
                        #("color", "#2c5282"),
                      ]),
                    ],
                    [element.text("Public Transit Options")],
                  ),
                  html.ul([], [
                    html.li([], [
                      element.text("Stagecoach Bus Routes: 50 and U7"),
                    ]),
                    html.a(
                      [
                        attribute.href(
                          "https://www.stagecoachbus.com/timetables",
                        ),
                        attribute.style([
                          #("color", "#2c52FF"),
                          #("text-decoration", "underline"),
                          #("font-weight", "600"),
                          #("padding", "1rem 4rem"),
                          // Larger click target
                        ]),
                      ],
                      [
                        html.li([], [
                          element.text("Click here to view bus timetables."),
                        ]),
                      ],
                    ),
                  ]),
                ]),
              ],
            ),
          ]),
        ],
      ),
      // Access directions section
      html.section(
        [
          attribute.style([
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
              attribute.style([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [element.text("Accessing the rehearsal room")],
          ),
          html.a([attribute.href("https://maps.chi.ac.uk/#room=C01-0-31")], [
            html.div(
              [
                attribute.style([
                  #("background-color", "#b2babc"),
                  #("padding", "1rem"),
                  #("border-radius", "8px"),
                  #("border", "1px solid #e2e8f0"),
                  #("transition", "background-color 0.2s ease"),
                  #("&:hover", "background-color: #edf2f7"),
                ]),
              ],
              [
                html.p(
                  [
                    attribute.style([
                      #("text-align", "center"),
                      #("margin-bottom", "0"),
                      #("max-width", "800px"),
                      #("margin-left", "auto"),
                      #("margin-right", "auto"),
                      #("color", "#2c52FF"),
                      #("text-decoration", "underline"),
                      #("font-weight", "600"),
                    ]),
                  ],
                  [
                    element.text(
                      "Click here to see a detailed map of the university campus",
                    ),
                  ],
                ),
              ],
            ),
          ]),
          html.img([
            attribute.src(
              "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/better_directions.png",
            ),
            styles.img_full(),
          ]),
        ],
      ),
      // Parking section
      html.section(
        [
          attribute.style([
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
              attribute.style([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [element.text("Parking Information")],
          ),
          html.p(
            [
              attribute.style([
                #("text-align", "center"),
                #("margin-bottom", "1rem"),
                #("max-width", "800px"),
                #("margin-left", "auto"),
                #("margin-right", "auto"),
              ]),
            ],
            [
              element.text(
                "Several parking options are available on the university grounds near our rehearsal space.",
              ),
            ],
          ),
          html.p(
            [
              attribute.style([
                #("text-align", "center"),
                #("margin-bottom", "2rem"),
                #("max-width", "800px"),
                #("margin-left", "auto"),
                #("margin-right", "auto"),
              ]),
            ],
            [
              element.text(
                "Please review the map above and the information below in order to plan your visit.",
              ),
            ],
          ),
          // Parking options main container
          html.div(
            [
              attribute.style([
                #("display", "flex"),
                #("flex-direction", "column"),
                #("gap", "2rem"),
              ]),
            ],
            [
              // Payment section
              html.div(
                [
                  attribute.style([
                    #("border", "1px solid #e2e8f0"),
                    #("border-radius", "8px"),
                    #("overflow", "hidden"),
                  ]),
                ],
                [
                  // Section header
                  html.div(
                    [
                      attribute.style([
                        #("background-color", "#2c5282"),
                        #("color", "white"),
                        #("padding", "1rem 1.5rem"),
                      ]),
                    ],
                    [
                      html.h3(
                        [
                          attribute.style([
                            #("margin", "0"),
                            #("font-size", "1.5rem"),
                          ]),
                        ],
                        [element.text("Paying to park")],
                      ),
                    ],
                  ),
                  // Section content
                  html.div([attribute.style([#("padding", "1.5rem")])], [
                    html.p([], [
                      element.text(
                        "Parking at the university is managed by paybyphone. See below for details of how to park using their website:",
                      ),
                    ]),
                    html.div(
                      [
                        attribute.style([
                          #("margin-top", "1rem"),
                          #("display", "flex"),
                          #("flex-wrap", "wrap"),
                          #("gap", "1.5rem"),
                        ]),
                      ],
                      [
                        // PayByPhone Link
                        html.a(
                          [
                            attribute.href(
                              "https://m2.paybyphone.co.uk/parking",
                            ),
                          ],
                          [
                            parking_detail_box(
                              "Link",
                              html.p(
                                [
                                  attribute.style([
                                    #("margin", "0"),
                                    #("color", "#2c52FF"),
                                    #("text-decoration", "underline"),
                                    #("font-weight", "600"),
                                  ]),
                                ],
                                [element.text("m2.paybyphone.co.uk")],
                              ),
                            ),
                          ],
                        ),
                        // Location number
                        parking_detail_box(
                          "Location Number",
                          html.p(
                            [
                              attribute.style([
                                #("margin", "0"),
                                #("color", "#4a5568"),
                              ]),
                            ],
                            [element.text("808365")],
                          ),
                        ),
                        // Cost
                        parking_detail_box(
                          "Cost",
                          html.p(
                            [
                              attribute.style([
                                #("margin", "0"),
                                #("color", "#4a5568"),
                              ]),
                            ],
                            [element.text("[costs]")],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
              // Accessibility parking information
              html.div(
                [
                  attribute.style([
                    #("border", "1px solid #e2e8f0"),
                    #("border-radius", "8px"),
                    #("overflow", "hidden"),
                  ]),
                ],
                [
                  // Section header
                  html.div(
                    [
                      attribute.style([
                        #("background-color", "#2c5282"),
                        #("color", "white"),
                        #("padding", "1rem 1.5rem"),
                      ]),
                    ],
                    [
                      html.h3(
                        [
                          attribute.style([
                            #("margin", "0"),
                            #("font-size", "1.5rem"),
                          ]),
                        ],
                        [element.text("Accessible Parking")],
                      ),
                    ],
                  ),
                  // Section content
                  html.div([attribute.style([#("padding", "1.5rem")])], [
                    html.p([], [
                      element.text(
                        "There is accessible parking available throughout the university campus.",
                      ),
                    ]),
                    html.a([attribute.href("https://maps.chi.ac.uk/")], [
                      html.p(
                        [
                          styles.styled_link(),
                          attribute.style([#("margin-top", "1rem")]),
                        ],
                        [
                          element.text(
                            "See the campus map for more precise parking details",
                          ),
                        ],
                      ),
                    ]),
                  ]),
                ],
              ),
            ],
          ),
        ],
      ),
      // Contact section
      html.section(
        [
          attribute.style([
            #("background-color", "#1a365d"),
            #("color", "white"),
            #("padding", "3rem 1rem"),
            #("text-align", "center"),
          ]),
        ],
        [
          html.h2(
            [
              attribute.style([
                #("font-size", "2rem"),
                #("margin-bottom", "1.5rem"),
              ]),
            ],
            [element.text("Contact Us for Directions")],
          ),
          html.p(
            [
              attribute.style([
                #("max-width", "600px"),
                #("margin", "0 auto 1.5rem auto"),
              ]),
            ],
            [
              element.text(
                "Need help finding us? Have questions about parking or accessibility? We're here to help!",
              ),
            ],
          ),
          html.div(
            [
              attribute.style([
                #("display", "flex"),
                #("flex-wrap", "wrap"),
                #("justify-content", "center"),
                #("gap", "2rem"),
                #("margin-top", "1rem"),
              ]),
            ],
            [
              html.div([], [
                html.p([attribute.style([#("font-weight", "bold")])], [
                  element.text("Email"),
                ]),
                html.p([], [element.text("caroline@chicommunitychoir.com")]),
              ]),
              // // Phone contact
            // html.div(
            //   [],
            //   [
            //     html.p(
            //       [
            //         attribute.style([
            //           #("font-weight", "bold"),
            //         ]),
            //       ],
            //       [element.text("Phone")],
            //     ),
            //     html.p([], [element.text("(+44) 7123 456 789")]),
            //   ],
            // ),
            ],
          ),
        ],
      ),
    ],
  )
}

// fn venue_card(name: String, address: String, description: String) -> Element(Msg) {
//   html.div(
//     [
//       attribute.style([
//         #("background-color", "white"),
//         #("border-radius", "8px"),
//         #("overflow", "hidden"),
//         #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
//         #("border", "1px solid #e2e8f0"),
//         #("transition", "transform 0.3s ease"),
//         #("&:hover", "transform: translateY(-5px)"),
//       ]),
//     ],
//     [
//       html.div(
//         [
//           attribute.style([
//             #("background-color", "#f8fafc"),
//             #("height", "120px"),
//             #("display", "flex"),
//             #("align-items", "center"),
//             #("justify-content", "center"),
//             #("color", "#1a365d"),
//             #("font-size", "1.5rem"),
//             #("font-weight", "bold"),
//             #("padding", "1rem"),
//             #("text-align", "center"),
//           ]),
//         ],
//         [element.text(name)],
//       ),
//       html.div(
//         [
//           attribute.style([
//             #("padding", "1.5rem"),
//           ]),
//         ],
//         [
//           html.p(
//             [
//               attribute.style([
//                 #("color", "#4a5568"),
//                 #("margin-bottom", "1rem"),
//                 #("font-style", "italic"),
//               ]),
//             ],
//             [element.text(address)],
//           ),
//           html.p(
//             [
//               attribute.style([
//                 #("color", "#2d3748"),
//               ]),
//             ],
//             [element.text(description)],
//           ),
//         ],
//       ),
//     ],
//   )
// }

fn parking_detail_box(title: String, content: Element(Msg)) -> Element(Msg) {
  html.div(
    [
      attribute.style([
        #("background-color", "#f8fafc"),
        #("border-radius", "6px"),
        #("padding", "1rem"),
        #("flex", "1 1 200px"),
        #("min-width", "200px"),
      ]),
    ],
    [
      html.h4(
        [
          attribute.style([
            #("margin", "0 0 0.5rem 0"),
            #("color", "#2c5282"),
            #("font-size", "1.1rem"),
          ]),
        ],
        [element.text(title)],
      ),
      content,
    ],
  )
}
// fn parking_facility_card(
//   name: String,
//   address: String,
//   rates: String,
//   hours: String,
//   distance: String,
// ) -> Element(Msg) {
//   html.div(
//     [
//       attribute.style([
//         #("background-color", "white"),
//         #("border", "1px solid #e2e8f0"),
//         #("border-radius", "8px"),
//         #("overflow", "hidden"),
//         #("box-shadow", "0 2px 4px rgba(0, 0, 0, 0.05)"),
//       ]),
//     ],
//     [
//       html.div(
//         [
//           attribute.style([
//             #("background-color", "#f0f9ff"),
//             #("border-bottom", "1px solid #e2e8f0"),
//             #("padding", "1rem"),
//           ]),
//         ],
//         [
//           html.h4(
//             [
//               attribute.style([
//                 #("margin", "0"),
//                 #("color", "#2c5282"),
//                 #("font-size", "1.2rem"),
//               ]),
//             ],
//             [element.text(name)],
//           ),
//         ],
//       ),
//       html.div(
//         [
//           attribute.style([
//             #("padding", "1rem"),
//           ]),
//         ],
//         [
//           html.p(
//             [
//               attribute.style([
//                 #("margin", "0 0 0.5rem 0"),
//                 #("font-style", "italic"),
//                 #("color", "#4a5568"),
//               ]),
//             ],
//             [element.text(address)],
//           ),
//           html.div(
//             [
//               attribute.style([
//                 #("margin-top", "1rem"),
//                 #("display", "grid"),
//                 #("grid-template-columns", "auto 1fr"),
//                 #("gap", "0.5rem 1rem"),
//                 #("font-size", "0.9rem"),
//               ]),
//             ],
//             [
//               html.div(
//                 [
//                   attribute.style([
//                     #("font-weight", "bold"),
//                     #("color", "#4a5568"),
//                   ]),
//                 ],
//                 [element.text("Rates:")],
//               ),
//               html.div([], [element.text(rates)]),
//               html.div(
//                 [
//                   attribute.style([
//                     #("font-weight", "bold"),
//                     #("color", "#4a5568"),
//                   ]),
//                 ],
//                 [element.text("Hours:")],
//               ),
//               html.div([], [element.text(hours)]),
//               html.div(
//                 [
//                   attribute.style([
//                     #("font-weight", "bold"),
//                     #("color", "#4a5568"),
//                   ]),
//                 ],
//                 [element.text("Distance:")],
//               ),
//               html.div([], [element.text(distance)]),
//             ],
//           ),
//         ],
//       ),
//     ],
//   )
// }

// fn payment_method_card(title: String, description: String) -> Element(Msg) {
//   html.div(
//     [
//       attribute.style([
//         #("background-color", "#f8fafc"),
//         #("border-radius", "8px"),
//         #("padding", "1.2rem"),
//         #("width", "220px"),
//         #("text-align", "center"),
//         #("box-shadow", "0 2px 4px rgba(0, 0, 0, 0.05)"),
//       ]),
//     ],
//     [
//       html.h4(
//         [
//           attribute.style([
//             #("margin", "0 0 0.8rem 0"),
//             #("color", "#2c5282"),
//             #("font-size", "1.1rem"),
//           ]),
//         ],
//         [element.text(title)],
//       ),
//       html.p(
//         [
//           attribute.style([
//             #("margin", "0"),
//             #("color", "#4a5568"),
//             #("font-size", "0.9rem"),
//           ]),
//         ],
//         [element.text(description)],
//       ),
//     ],
//   )
// }
