/// Flip to `true` right before a production deploy (`flutter build web`),
/// and back to `false` while developing locally (`flutter run`). Picks
/// which API base URL every request goes to — see [apiProdBase] /
/// [apiDebugBase] below.
const bool production = true;

const String apiProdBase = 'https://portfolio-be-ehsu.onrender.com';
const String apiDebugBase = 'http://localhost:5000';
