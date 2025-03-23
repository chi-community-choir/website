import lustre/element/html
import lustre/attribute.{style}

/// Default page styling, for uniformity
pub fn page_default() {
  style([
    #("display", "flex"),
    #("flex-direction", "column"),
    #("min-height", "100vh"),
    #("padding", "0"),
    #("margin", "0"),
  ])
}

/// Container with two items side by side, wrapping on small screens.
pub fn aside_wrap() {
  style([
    #("display", "flex"),
    #("flex-flow", "row wrap"),
    #("align-items", "center"),
    #("justify-content", "center"),
    #("gap", "1rem 2rem"),
    #("padding", "2rem 1rem"),
    #("max-width", "100%"),
    #("margin", "0 auto"),
  ])
}

pub fn styled_link() {
  style([
    #("color", "#2c52FF"),
    #("text-decoration", "underline"),
    #("font-weight", "600"),
  ])
}

/// Limits the size of an image by its height
pub fn img_md() {
  style([
    #("max-width", "100%"),
    #("height", "auto"),
    #("max-height", "400px"),
    #("object-fit", "contain"),
  ])
}

pub fn img_full() {
  style([
    #("max-width", "100%"),
    #("height", "auto"),
    #("object-fit", "contain"),
  ])
}

pub fn markdown() {
  html.style([], "
/* General Styling for the <markdown> container */
markdown {
  display: block; /* Treat it like a block-level element */
  margin-bottom: 2em; /* Space between posts/sections */
  padding: 1.5em;
  border: 1px solid #eee; /* Subtle border */
  border-radius: 8px;
  background-color: #f9f9f9; /* Very light background */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* Soft shadow */
  font-family: 'Arial', sans-serif; /* Readable font */
  font-size: 16px;
  line-height: 1.6;
  color: #333; /* Dark grey for readability */
}

/* Headings */
markdown h1 {
  font-size: 2.2em;
  margin-top: 0;
  margin-bottom: 0.5em;
  color: #4a4a4a;
  border-bottom: 1px solid #ddd;
  padding-bottom: 0.3em;
}

markdown h2 {
  font-size: 1.8em;
  margin-top: 1.5em;
  margin-bottom: 0.4em;
  color: #555;
}

markdown h3 {
  font-size: 1.4em;
  margin-top: 1.2em;
  margin-bottom: 0.3em;
  color: #666;
}

markdown h4 {
  font-size: 1.2em;
  margin-top: 1em;
  margin-bottom: 0.2em;
  color: #777;
}

markdown h5 {
  font-size: 1em;
  margin-top: 0.8em;
  margin-bottom: 0.1em;
  color: #888;
}

markdown h6 {
  font-size: 0.8em;
  margin-top: 0.6em;
  margin-bottom: 0;
  color: #999;
}

/* Paragraphs */
markdown p {
  margin-bottom: 1em;
}

/* Links */
markdown a {
  color: #007bff; /* A friendly blue */
  text-decoration: none;
}

markdown a:hover {
  text-decoration: underline;
  color: #0056b3; /* Darker blue on hover */
}

/* Lists */
markdown ul, markdown ol {
  margin-left: 2em;
  margin-bottom: 1em;
}

markdown li {
  margin-bottom: 0.3em;
}

/* Code */
markdown code {
  background-color: #f0f0f0;
  padding: 2px 5px;
  border-radius: 3px;
  font-family: 'Courier New', monospace;
  font-size: 0.9em;
}

markdown pre {
  background-color: #f0f0f0;
  padding: 1em;
  border-radius: 5px;
  overflow-x: auto; /* Horizontal scroll for long code blocks */
  font-family: 'Courier New', monospace;
  font-size: 0.9em;
}

/* Blockquotes */
markdown blockquote {
  border-left: 4px solid #ccc;
  padding-left: 1em;
  margin-bottom: 1em;
  font-style: italic;
  color: #666;
}

/* Images */
markdown img {
  max-width: 100%;
  height: auto;
  display: block; /* Makes images behave like blocks */
  margin: 0 auto; /* Centers images */
}

/* Horizontal Rule */
markdown hr {
  border: none;
  border-top: 1px solid #ddd;
  margin: 1.5em 0;
}

/* Tables */
markdown table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 1em;
}

markdown th, markdown td {
  padding: 0.5em;
  border: 1px solid #ddd;
  text-align: left;
}

markdown th {
  background-color: #f0f0f0;
  font-weight: bold;
}
  ")
}
