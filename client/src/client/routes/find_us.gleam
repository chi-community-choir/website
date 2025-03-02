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
            #("padding", "3rem 1rem"),
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
                "Join us for rehearsals or attend our performances. Here's where you can find the Chichester Community Choir.",
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
                #("margin-bottom", "1.5rem"),
                #("color", "#1a365d"),
                #("text-align", "center"),
              ]),
            ],
            [element.text("Rehearsal Location")],
          ),
          html.div(
            [styles.aside_wrap()],
            [
              // Map or image placeholder
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
                        attribute.src("https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d445.3519737708294!2d-0.7747135588194097!3d50.84429154622754!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2suk!4v1740937216243!5m2!1sen!2suk"),
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
                [
                  attribute.style([
                    #("flex", "1 1 400px"),
                    #("padding", "1rem"),
                  ]),
                ],
                [
                  html.h3(
                    [
                      attribute.style([
                        #("font-size", "1.5rem"),
                        #("margin-bottom", "1rem"),
                        #("color", "#2c5282"),
                      ]),
                    ],
                    [element.text("University of Chichester")],
                  ),
                  html.p(
                    [],
                    [
                      element.text("College Ln"),
                      html.br([]),
                      element.text("Chichester, PO19 6PF"),
                    ],
                  ),
                  html.p(
                    [
                      attribute.style([
                        #("margin-top", "1rem"),
                      ]),
                    ],
                    [
                      element.text(
                        "We rehearse every Tuesday evening from 6:45 PM to 8:15 PM in the cloisters at the University of Chichester. The building is accessible via public transit, with parking also available on the university grounds.",
                      ),
                    ],
                  ),
                  html.div(
                    [
                      attribute.style([
                        #("margin-top", "1.5rem"),
                      ]),
                    ],
                    [
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
                      html.ul(
                        [],
                        [
                          html.li([], [element.text("Stagecoach Bus Routes: 50 and U7")]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // // Performance venues section
      // html.section(
      //   [
      //     attribute.style([
      //       #("max-width", "1200px"),
      //       #("margin", "0 auto 3rem auto"),
      //       #("padding", "2rem"),
      //       #("background-color", "white"),
      //       #("border-radius", "8px"),
      //       #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
      //     ]),
      //   ],
      //   [
      //     html.h2(
      //       [
      //         attribute.style([
      //           #("font-size", "2rem"),
      //           #("margin-bottom", "1.5rem"),
      //           #("color", "#1a365d"),
      //           #("text-align", "center"),
      //         ]),
      //       ],
      //       [element.text("Performance Venues")],
      //     ),
      //     html.p(
      //       [
      //         attribute.style([
      //           #("text-align", "center"),
      //           #("margin-bottom", "2rem"),
      //         ]),
      //       ],
      //       [
      //         element.text(
      //           "The Chichester Community Choir performs at various venues throughout the year. Here are some of our regular performance locations:",
      //         ),
      //       ],
      //     ),
      //     // Venue cards
      //     html.div(
      //       [
      //         attribute.style([
      //           #("display", "grid"),
      //           #("grid-template-columns", "repeat(auto-fill, minmax(300px, 1fr))"),
      //           #("gap", "2rem"),
      //         ]),
      //       ],
      //       [
      //         // Venue 1
      //         venue_card(
      //           "Harris Theater",
      //           "205 E Randolph St, Chicago, IL 60601",
      //           "Our annual holiday concert is typically held at this downtown venue.",
      //         ),
      //         // Venue 2
      //         venue_card(
      //           "Logan Center for the Arts",
      //           "915 E 60th St, Chicago, IL 60637",
      //           "We often perform our spring showcase at this University of Chicago venue.",
      //         ),
      //         // Venue 3
      //         venue_card(
      //           "Garfield Park Conservatory",
      //           "300 N Central Park Ave, Chicago, IL 60624",
      //           "Our summer series features performances in this beautiful garden setting.",
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

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
          html.img([
            attribute.src("https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/walking_directions.png"),
            styles.img_md(),
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
                #("margin-bottom", "2rem"),
                #("max-width", "800px"),
                #("margin-left", "auto"),
                #("margin-right", "auto"),
              ]),
            ],
            [
              element.text(
                "Several parking options are available near our rehearsal space. Please review the information below to plan your visit.",
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
              // On-site parking section
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
                        [element.text("On-site Parking")],
                      ),
                    ],
                  ),
                  // Section content
                  html.div(
                    [
                      attribute.style([
                        #("padding", "1.5rem"),
                      ]),
                    ],
                    [
                      html.p(
                        [],
                        [
                          element.text(
                            "[PLACEHOLDER: Description of on-site parking options, including location, capacity, and any special instructions]",
                          ),
                        ],
                      ),
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
                          // Hours
                          parking_detail_box(
                            "Hours",
                            "[PLACEHOLDER: Operating hours for this parking option]",
                          ),
                          // Cost
                          parking_detail_box(
                            "Cost",
                            "[PLACEHOLDER: Pricing information for this parking option]",
                          ),
                          // Payment Methods
                          parking_detail_box(
                            "Payment Methods",
                            "[PLACEHOLDER: Accepted payment methods (cash, card, app, etc.)]",
                          ),
                        ],
                      ),
                    ],
                  ),
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
                  html.div(
                    [
                      attribute.style([
                        #("padding", "1.5rem"),
                      ]),
                    ],
                    [
                      html.p(
                        [],
                        [
                          element.text(
                            "[PLACEHOLDER: Information about accessible parking spaces, including locations, quantity, and any special instructions]",
                          ),
                        ],
                      ),
                      html.p(
                        [
                          attribute.style([
                            #("margin-top", "1rem"),
                          ]),
                        ],
                        [
                          element.text(
                            "[PLACEHOLDER: Information about accessible routes from parking to venue entrance]",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // // Payment options section
              // html.div(
              //   [
              //     attribute.style([
              //       #("border", "1px solid #e2e8f0"),
              //       #("border-radius", "8px"),
              //       #("overflow", "hidden"),
              //     ]),
              //   ],
              //   [
              //     // Section header
              //     html.div(
              //       [
              //         attribute.style([
              //           #("background-color", "#2c5282"),
              //           #("color", "white"),
              //           #("padding", "1rem 1.5rem"),
              //         ]),
              //       ],
              //       [
              //         html.h3(
              //           [
              //             attribute.style([
              //               #("margin", "0"),
              //               #("font-size", "1.5rem"),
              //             ]),
              //           ],
              //           [element.text("Payment Options")],
              //         ),
              //       ],
              //     ),
              //     // Section content
              //     html.div(
              //       [
              //         attribute.style([
              //           #("padding", "1.5rem"),
              //         ]),
              //       ],
              //       [
              //         html.p(
              //           [],
              //           [
              //             element.text(
              //               "[PLACEHOLDER: Overview of payment options for various parking facilities]",
              //             ),
              //           ],
              //         ),
              //         html.div(
              //           [
              //             attribute.style([
              //               #("margin-top", "1.5rem"),
              //               #("display", "flex"),
              //               #("flex-wrap", "wrap"),
              //               #("gap", "2rem"),
              //               #("justify-content", "center"),
              //             ]),
              //           ],
              //           [
              //             // Cash
              //             payment_method_card("Cash", "[PLACEHOLDER: Where cash is accepted]"),
              //             // Credit/Debit Cards
              //             payment_method_card(
              //               "Credit/Debit Cards",
              //               "[PLACEHOLDER: Where cards are accepted and any restrictions]",
              //             ),
              //             // Mobile Payment
              //             payment_method_card(
              //               "Mobile Payment",
              //               "[PLACEHOLDER: Mobile payment options, apps, etc.]",
              //             ),
              //             // Prepaid Parking
              //             payment_method_card(
              //               "Prepaid Parking",
              //               "[PLACEHOLDER: Information about prepaid parking options if available]",
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              // Tips and recommendations
              html.div(
                [
                  attribute.style([
                    #("margin-top", "2rem"),
                    #("background-color", "#f8fafc"),
                    #("border-radius", "8px"),
                    #("padding", "1.5rem"),
                    #("border-left", "4px solid #2c5282"),
                  ]),
                ],
                [
                  html.h3(
                    [
                      attribute.style([
                        #("color", "#1a365d"),
                        #("margin-top", "0"),
                        #("margin-bottom", "1rem"),
                      ]),
                    ],
                    [element.text("Tips for Parking [Probably remove]")],
                  ),
                  html.ul(
                    [
                      attribute.style([
                        #("margin", "0"),
                        #("padding-left", "1.5rem"),
                      ]),
                    ],
                    [
                      html.li(
                        [
                          attribute.style([
                            #("margin-bottom", "0.5rem"),
                          ]),
                        ],
                        [
                          element.text(
                            "[PLACEHOLDER: Tip 1 about arriving early, best spots, etc.]",
                          ),
                        ],
                      ),
                      html.li(
                        [
                          attribute.style([
                            #("margin-bottom", "0.5rem"),
                          ]),
                        ],
                        [
                          element.text(
                            "[PLACEHOLDER: Tip 2 about peak times, avoiding congestion, etc.]",
                          ),
                        ],
                      ),
                      html.li(
                        [
                          attribute.style([
                            #("margin-bottom", "0.5rem"),
                          ]),
                        ],
                        [
                          element.text(
                            "[PLACEHOLDER: Tip 3 about payment preparation, apps to download, etc.]",
                          ),
                        ],
                      ),
                      html.li([], [element.text("[PLACEHOLDER: Tip 4, additional advice]")]),
                    ],
                  ),
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
              html.div(
                [],
                [
                  html.p(
                    [
                      attribute.style([
                        #("font-weight", "bold"),
                      ]),
                    ],
                    [element.text("Email")],
                  ),
                  html.p([], [element.text("caroline@chicommunitychoir.com")]),
                ],
              ),
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

fn parking_detail_box(title: String, content: String) -> Element(Msg) {
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
      html.p(
        [
          attribute.style([
            #("margin", "0"),
            #("color", "#4a5568"),
          ]),
        ],
        [element.text(content)],
      ),
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

fn payment_method_card(title: String, description: String) -> Element(Msg) {
  html.div(
    [
      attribute.style([
        #("background-color", "#f8fafc"),
        #("border-radius", "8px"),
        #("padding", "1.2rem"),
        #("width", "220px"),
        #("text-align", "center"),
        #("box-shadow", "0 2px 4px rgba(0, 0, 0, 0.05)"),
      ]),
    ],
    [
      html.h4(
        [
          attribute.style([
            #("margin", "0 0 0.8rem 0"),
            #("color", "#2c5282"),
            #("font-size", "1.1rem"),
          ]),
        ],
        [element.text(title)],
      ),
      html.p(
        [
          attribute.style([
            #("margin", "0"),
            #("color", "#4a5568"),
            #("font-size", "0.9rem"),
          ]),
        ],
        [element.text(description)],
      ),
    ],
  )
}
