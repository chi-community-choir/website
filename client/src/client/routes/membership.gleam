import client/lib/model.{type Model}
import client/lib/msg.{type Msg}
import client/styles
import gleam/list
import gleam/option.{None, Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn membership(model: Model) -> Element(Msg) {
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
            [element.text("Membership")],
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
                "Join our choir community and help support our mission through your membership.",
              ),
            ],
          ),
        ],
      ),
      // Membership fees section
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
            [element.text("Membership Fees")],
          ),
          html.p(
            [
              attribute.style([
                #("text-align", "center"),
                #("max-width", "800px"),
                #("margin", "0 auto 2rem auto"),
              ]),
            ],
            [
              element.text(
                "Our choir is run as a non-profit organization, and membership fees help cover our essential costs. We strive to keep fees affordable while providing a high-quality choral experience.",
              ),
            ],
          ),
          html.p(
            [
              attribute.style([
                #("text-align", "center"),
                #("max-width", "800px"),
                #("margin", "0 auto 2rem auto"),
              ]),
            ],
            [
              element.text(
                "Prospective members are welcome to join us for a rehearsal to get a feel for the choir before committing - no need to worry about payment until you decide to join.",
              ),
            ],
          ),
          html.div(
            [
              attribute.style([
                #("max-width", "800px"),
                #("margin", "0 auto 2rem"),
                #("background-color", "white"),
                #("border-radius", "8px"),
                #("border", "1px solid #e2e8f0"),
                #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
                #("padding", "2rem"),
              ]),
            ],
            [
              html.h3(
                [
                  attribute.style([
                    #("margin", "0 0 1rem 0"),
                    #("font-size", "1.5rem"),
                    #("color", "#2c5282"),
                    #("text-align", "center"),
                  ]),
                ],
                [element.text("Membership Information")],
              ),
              html.div(
                [
                  attribute.style([
                    #("text-align", "center"),
                    #("margin-bottom", "1.5rem"),
                    #("padding", "1rem"),
                    #("background-color", "#f7fafc"),
                    #("border-radius", "4px"),
                  ]),
                ],
                [
                  html.span(
                    [
                      attribute.style([
                        #("font-size", "1.8rem"),
                        #("font-weight", "bold"),
                        #("color", "#2c5282"),
                      ]),
                    ],
                    [element.text("£28")],
                  ),
                  html.span(
                    [
                      attribute.style([
                        #("font-size", "1.2rem"),
                        #("color", "#4a5568"),
                        #("margin-left", "0.5rem"),
                      ]),
                    ],
                    [element.text("per month")],
                  ),
                ],
              ),
              html.p(
                [
                  attribute.style([
                    #("text-align", "center"),
                    #("margin-bottom", "1.5rem"),
                    #("color", "#4a5568"),
                  ]),
                ],
                [
                  element.text(
                    "Your membership includes access to all choir activities and resources. We aim to make music accessible to everyone while maintaining the quality of our performances.",
                  ),
                ],
              ),
              html.div([attribute.style([#("margin-bottom", "1.5rem")])], [
                html.h4(
                  [
                    attribute.style([
                      #("font-size", "1.2rem"),
                      #("color", "#2c5282"),
                      #("margin-bottom", "1rem"),
                    ]),
                  ],
                  [element.text("What's Included:")],
                ),
                html.ul(
                  [
                    attribute.style([
                      #("padding-left", "1.5rem"),
                      #("margin", "0"),
                      #("color", "#4a5568"),
                    ]),
                  ],
                  list.map(
                    [
                      "Weekly rehearsals with professional direction",
                      "All sheet music and practice materials provided",
                      "Regular performance opportunities throughout the year",
                      "Access to social events and choir community",
                      "Online practice resources and recordings",
                    ],
                    fn(benefit) {
                      html.li(
                        [attribute.style([#("margin-bottom", "0.5rem")])],
                        [element.text(benefit)],
                      )
                    },
                  ),
                ),
              ]),
            ],
          ),
          // Payment options
          html.div(
            [
              attribute.style([
                #("background-color", "#f8fafc"),
                #("border-radius", "8px"),
                #("padding", "1.5rem"),
                #("margin-bottom", "2rem"),
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
                [element.text("Payment Options")],
              ),
              html.ul(
                [
                  attribute.style([
                    #("padding-left", "1.5rem"),
                    #("margin-bottom", "1rem"),
                    #("list-style-type", "disc"),
                  ]),
                ],
                [
                  html.li([], [element.text("Please pay via bank transfer.")]),
                  html.li([], [
                    element.text(
                      "Financial assistance available - please speak with Caroline in confidence",
                    ),
                  ]),
                ],
              ),
              html.p([attribute.style([#("font-style", "italic")])], [
                element.text(
                  "Note: Membership fees are due on the 1st of each month.",
                ),
              ]),
            ]
              |> list.append(case model.auth_user {
                None -> [
                  html.div(
                    [
                      attribute.style([
                        #("text-align", "center"),
                        #("background-color", "#4299e1"),
                        #("color", "white"),
                        #("padding", "1.5rem"),
                        #("border-radius", "8px"),
                        #("margin-top", "1.5rem"),
                        #("font-size", "1.2rem"),
                        #("font-weight", "bold"),
                        #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
                        #("border", "2px solid #2c5282"),
                      ]),
                    ],
                    [element.text("⚠️ Please login to view our bank details")],
                  ),
                ]
                Some(_) -> [
                  html.div(
                    [
                      attribute.style([
                        #("text-align", "center"),
                        #("background-color", "#4299e1"),
                        #("color", "white"),
                        #("padding", "1.5rem"),
                        #("border-radius", "8px"),
                        #("margin-top", "1.5rem"),
                        #("font-size", "1.2rem"),
                        #("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)"),
                        #("border", "2px solid #2c5282"),
                      ]),
                    ],
                    [
                      html.div(
                        [
                          attribute.style([
                            #("font-weight", "bold"),
                            #("font-size", "1.3rem"),
                            #("margin-bottom", "1rem"),
                          ]),
                        ],
                        [element.text("Payment Details 💳")],
                      ),
                      html.div([attribute.style([#("font-size", "1.1rem")])], [
                        element.text("Sort code: 00-00-00"),
                      ]),
                      html.div(
                        [
                          attribute.style([
                            #("margin-top", "0.5rem"),
                            #("font-size", "1.1rem"),
                          ]),
                        ],
                        [element.text("Account number: 12345678")],
                      ),
                    ],
                  ),
                ]
              }),
          ),
        ],
      ),
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
            [element.text("Where Your Membership Fees Go")],
          ),
          html.div(
            [
              attribute.style([
                #("text-align", "center"),
                #("max-width", "800px"),
                #("margin", "0 auto"),
                #("line-height", "1.6"),
              ]),
            ],
            [
              html.p([], [
                element.text(
                  "Your membership fees help keep the choir running smoothly! They cover essentials like sheet music, venue hire for rehearsals, insurance, and concert production costs.",
                ),
              ]),
              html.p([attribute.style([#("margin-top", "1rem")])], [
                element.text(
                  "Want more details about how we use the funds? Just ask - we're always happy to chat about our financial management.",
                ),
              ]),
            ],
          ),
        ],
      ),
      // FAQ section
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
            [element.text("Frequently Asked Questions")],
          ),
          faq_item(
            "Can I try out the choir before committing to membership?",
            "Absolutely! We invite potential members to attend one of our rehearsals free of charge before making a decision about joining. This gives you an opportunity to meet current members and experience our rehearsal process.",
          ),
          faq_item(
            "Do I need prior singing experience to join?",
            "Not at all! We welcome singers of all experience levels. Our supportive environment and professional direction will help you develop your voice and musical skills. The only requirements are enthusiasm and a willingness to learn!",
          ),
          faq_item(
            "What happens if I need to leave the choir mid-season?",
            "We understand that circumstances change. Monthly memberships can be canceled with 30 days' notice.",
          ),
          faq_item(
            "Do you offer any financial assistance programs?",
            "Yes, we have a limited financial assistance fund to help those who may be experiencing hardship. Applications are confidential and are reviewed by a small committee. Please speak with our treasurer for more information.",
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
            [element.text("Questions About Membership?")],
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
                "If you have any questions about membership fees or payment options, feel free to get in touch!",
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
            //     html.p([], [element.text("(312) 555-0124")]),
            //   ],
            // ),
            ],
          ),
        ],
      ),
    ],
  )
}

fn faq_item(question: String, answer: String) -> Element(Msg) {
  html.div(
    [
      attribute.style([
        #("margin-bottom", "1.5rem"),
        #("border-bottom", "1px solid #e2e8f0"),
        #("padding-bottom", "1.5rem"),
      ]),
    ],
    [
      html.h3(
        [
          attribute.style([
            #("margin", "0 0 0.75rem 0"),
            #("font-size", "1.3rem"),
            #("color", "#2c5282"),
          ]),
        ],
        [element.text(question)],
      ),
      html.p([attribute.style([#("margin", "0"), #("color", "#4a5568")])], [
        element.text(answer),
      ]),
    ],
  )
}
