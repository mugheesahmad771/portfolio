import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/api_constant.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/services/auth_service.dart';

/// Blocks every admin route in a production build. The dashboard and its
/// create/edit/message pages are only ever reachable when developing
/// locally (`production == false` in api_constant.dart) — bounce anyone
/// hitting an admin URL on the live site straight back to the homepage.
class ProductionGuardMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    if (production) return const RouteSettings(name: AppRoute.home);
    return null;
  }
}

/// Requires an authenticated admin session. Applied to every admin route
/// except the dashboard itself, which already renders its own login form
/// when logged out — so this just sends anyone who lands directly on a
/// create/edit URL (e.g. a bookmarked or guessed link) back there to sign
/// in first, instead of exposing the form.
class AuthGuardMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.find<AuthService>().isAuthenticated) {
      return const RouteSettings(name: AppRoute.admin);
    }
    return null;
  }
}
