export function get_route() {
  return window.location.pathname;
}

export function set_url(url) {
  window.history.replaceState({}, null, url);
}

export function set_clipboard(text) {
  navigator.clipboard.writeText(text);
}

import markdownit from 'markdown-it'
const md = markdownit()

export function render_markdown(text) {
  return md.render(text);
}
