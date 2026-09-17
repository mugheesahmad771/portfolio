import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/core/constants/route_meta.dart';
import 'package:portfolio/core/middleware/admin_guard_middleware.dart';
import 'package:portfolio/core/utils/page_meta.dart';
import 'package:portfolio/services/auth_service.dart';
import 'package:portfolio/services/contact_service.dart';
import 'package:portfolio/services/experience_service.dart';
import 'package:portfolio/services/project_service.dart';
import 'package:portfolio/pages/about/ui/about_page.dart';
import 'package:portfolio/pages/admin/ui/admin_dashboard_page.dart';
import 'package:portfolio/pages/contact/ui/contact_page.dart';
import 'package:portfolio/pages/experience/ui/experience_page.dart';
import 'package:portfolio/pages/experience_form/ui/experience_form_page.dart';
import 'package:portfolio/pages/home/ui/home_page.dart';
import 'package:portfolio/pages/project_detail/ui/project_detail_page.dart';
import 'package:portfolio/pages/project_form/ui/project_form_page.dart';
import 'package:portfolio/pages/projects/ui/projects_page.dart';
import 'package:portfolio/pages/resume/ui/resume_page.dart';
import 'package:portfolio/pages/skills/ui/skills_page.dart';
import 'package:portfolio/views/app_layout.dart';
import 'package:portfolio/views/app_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clean, crawlable URLs (e.g. /about) instead of the default /#/about hash
  // routing — hash fragments are poorly indexed by search engines and break
  // canonical/OG URLs pointing at individual routes.
  usePathUrlStrategy();

  // Initialize services — registered ONCE here (not per-viewmodel) so every
  // page shares the same instances. This is what makes admin CRUD changes
  // actually show up on the public pages instead of only within whichever
  // screen made the change.
  Get.put<AuthService>(AuthService());
  Get.put<ProjectService>(ProjectService());
  Get.put<ExperienceService>(ExperienceService());
  Get.put<ContactService>(ContactService());
  await Get.find<AuthService>().restoreSession();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.transparent,
      overlayWidgetBuilder: (progress) {
        return const AppLoader();
      },
      child: GetMaterialApp(
        title: 'Portfolio',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.bg,
          useMaterial3: true,
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Inter'),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.bgSecondary,
            foregroundColor: AppColors.heading,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.heading),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.home,
        routingCallback: (routing) {
          final current = routing?.current;
          if (current == null || current.isEmpty) return;
          final meta = metaForRoute(current);
          setPageMeta(title: meta.title, description: meta.description);

          // Without this, ScrollReveal content that's already on-screen the
          // instant a new page lands (nothing below the fold to "scroll"
          // into) stays invisible until visibility_detector's own ~500ms
          // timer gets around to checking it — a visible blank flash on
          // every navigation. Forcing an immediate check right after the
          // route settles removes that delay.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            VisibilityDetectorController.instance.notifyNow();
          });
        },
        getPages: [
          // Public pages - wrapped with AppLayout
          GetPage(
            // Bare "/" must resolve too — with path-based URL strategy the
            // browser's real starting path (not `initialRoute`) is what GetX
            // looks up, so without this entry the site 404s at the domain
            // root.
            name: '/',
            page: () => const AppLayout(child: HomePage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.home,
            page: () => const AppLayout(child: HomePage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.about,
            page: () => const AppLayout(child: AboutPage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.projects,
            page: () => const AppLayout(child: ProjectsPage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.projectDetail,
            page: () => const AppLayout(child: ProjectDetailPage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.experience,
            page: () => const AppLayout(child: ExperiencePage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.skills,
            page: () => const AppLayout(child: SkillsPage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.contact,
            page: () => const AppLayout(child: ContactPage()),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.resume,
            page: () => const AppLayout(child: ResumePage()),
            transition: Transition.fadeIn,
          ),
          // Admin pages - no layout wrapper. Blocked entirely in production
          // (see ProductionGuardMiddleware); the form pages additionally
          // require an active login (see AuthGuardMiddleware) since the
          // dashboard itself is the only one that renders a login form.
          GetPage(
            name: AppRoute.admin,
            page: () => const AdminDashboardPage(),
            transition: Transition.fadeIn,
            middlewares: [ProductionGuardMiddleware()],
          ),
          GetPage(
            name: AppRoute.projectForm,
            page: () => const ProjectFormPage(),
            transition: Transition.fadeIn,
            middlewares: [ProductionGuardMiddleware(), AuthGuardMiddleware()],
          ),
          GetPage(
            name: AppRoute.projectFormEdit,
            page: () => const ProjectFormPage(),
            transition: Transition.fadeIn,
            middlewares: [ProductionGuardMiddleware(), AuthGuardMiddleware()],
          ),
          GetPage(
            name: AppRoute.adminExperienceForm,
            page: () => const ExperienceFormPage(),
            transition: Transition.fadeIn,
            middlewares: [ProductionGuardMiddleware(), AuthGuardMiddleware()],
          ),
          GetPage(
            name: AppRoute.adminExperienceFormEdit,
            page: () => const ExperienceFormPage(),
            transition: Transition.fadeIn,
            middlewares: [ProductionGuardMiddleware(), AuthGuardMiddleware()],
          ),
        ],
      ),
    );
  }
}
