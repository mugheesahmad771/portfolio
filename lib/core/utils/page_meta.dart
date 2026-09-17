import 'package:web/web.dart' as web;

/// Updates the browser tab title and the `<meta name="description">` /
/// `og:*` / `twitter:*` tags in `web/index.html`.
///
/// Flutter Web renders everything into that one static HTML shell, so
/// without this every route shares the exact same title/description a
/// browser tab, bookmark, or JS-executing crawler sees. Safe to call
/// repeatedly (e.g. once per route change, then again once async page data
/// loads) — each call just overwrites the current values.
///
/// Web-only by design (this project has no android/ios/desktop targets);
/// if that ever changes, guard calls with `kIsWeb`.
void setPageMeta({required String title, String? description}) {
  web.document.title = title;

  void setMeta(String selector) {
    if (description == null) return;
    web.document.querySelector(selector)?.setAttribute('content', description);
  }

  setMeta('meta[name="description"]');
  setMeta('meta[property="og:description"]');
  setMeta('meta[name="twitter:description"]');

  web.document
      .querySelector('meta[property="og:title"]')
      ?.setAttribute('content', title);
  web.document
      .querySelector('meta[name="twitter:title"]')
      ?.setAttribute('content', title);
}
