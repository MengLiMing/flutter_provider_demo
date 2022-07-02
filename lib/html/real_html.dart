import 'dart:html' as html;

class window {
  static dynamic open(String url, String name, [String? options]) {
    html.window.open(url, name, options);
  }
}
