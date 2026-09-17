import 'package:portfolio/core/constants/app_route.dart';

class RouteMeta {
  final String title;
  final String description;
  const RouteMeta(this.title, this.description);
}

const String _brand = 'Mughees Ahmad — Flutter & Full-Stack Developer';

const RouteMeta _home = RouteMeta(
  _brand,
  'Mughees Ahmad — Senior Flutter & Full-Stack Developer at HBit Technology LLC. 3+ years building production Flutter, React Native, Angular and ASP.NET Core applications.',
);

/// Static per-route `<title>` / meta description content, applied via
/// [setPageMeta] from `routingCallback` in main.dart. Keys are route paths
/// (`AppRoute.*`); the project-detail route (`/projects/:slug`) is handled
/// separately since it needs the loaded project's own title/description —
/// see [ProjectDetailViewModel].
const Map<String, RouteMeta> routeMeta = {
  '/': _home,
  AppRoute.home: _home,
  AppRoute.about: RouteMeta(
    'About — $_brand',
    'About Mughees Ahmad: background, engineering approach and the path to becoming a Senior Flutter & Full-Stack Developer building production mobile and web apps.',
  ),
  AppRoute.experience: RouteMeta(
    'Experience — $_brand',
    'Professional work history of Mughees Ahmad, Senior Flutter & Full-Stack Developer — roles, companies and technologies across 3+ years in production app development.',
  ),
  AppRoute.projects: RouteMeta(
    'Projects — $_brand',
    'Production Flutter, React Native and full-stack projects built by Mughees Ahmad, including enterprise work shown NDA-safe.',
  ),
  AppRoute.skills: RouteMeta(
    'Skills — $_brand',
    'Technical skills of Mughees Ahmad: Flutter, React Native, Angular, ASP.NET Core and full-stack mobile/web app development.',
  ),
  AppRoute.resume: RouteMeta(
    'Resume — $_brand',
    'Resume of Mughees Ahmad, Senior Flutter & Full-Stack Developer at HBit Technology LLC — download the full CV as PDF.',
  ),
  AppRoute.contact: RouteMeta(
    'Contact — $_brand',
    'Get in touch with Mughees Ahmad for Flutter, React Native and full-stack development opportunities.',
  ),
};

const RouteMeta projectDetailFallbackMeta = RouteMeta(
  'Project — $_brand',
  'A production project built by Mughees Ahmad, Senior Flutter & Full-Stack Developer.',
);

/// Resolves meta for an actual navigated path (e.g. `/projects/my-app`),
/// not a route pattern — falls back to the generic project-detail meta for
/// any `/projects/<slug>` path, and to the homepage meta for anything
/// unrecognized rather than showing stale/wrong content.
RouteMeta metaForRoute(String route) {
  final exact = routeMeta[route];
  if (exact != null) return exact;
  if (route.startsWith('${AppRoute.projects}/')) {
    return projectDetailFallbackMeta;
  }
  return _home;
}
