/// Flip to `true` right before a production deploy (`flutter build web`),
/// and back to `false` while developing locally (`flutter run`).
///
/// Also gates the admin panel entirely — see `AdminGuardMiddleware` — so
/// the dashboard and its create/edit/message pages are only ever reachable
/// against a local dev backend, never on the live production site.
const bool production = false;

// TODO: point this at the real deployed backend once it's live.
const String apiProdBase = '';
const String apiDebugBase = 'http://localhost:5000';
