import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/pages/admin/ui/admin_dashboard_page.dart';
import 'package:portfolio/pages/admin/ui/create_project_page.dart';
import 'package:portfolio/pages/contact/ui/contact_page.dart';
import 'package:portfolio/pages/edit_project/ui/edit_project_page.dart';
import 'package:portfolio/pages/experience/ui/experience_page.dart';
import 'package:portfolio/pages/home/ui/home_page.dart';
import 'package:portfolio/pages/project_detail/ui/project_detail_page.dart';
import 'package:portfolio/pages/projects/ui/projects_page.dart';
import 'package:portfolio/pages/resume/ui/resume_page.dart';
import 'package:portfolio/pages/skills/ui/skills_page.dart';
import 'package:portfolio/services/auth_service.dart';
import 'package:portfolio/views/app_layout.dart';
import 'package:portfolio/views/app_loader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  Get.put<AuthService>(AuthService());
  
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
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.bgSecondary,
            foregroundColor: AppColors.heading,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.heading),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.home,
        getPages: [
          // Public pages - wrapped with AppLayout
          GetPage(
            name: AppRoute.home,
            page: () => const AppLayout(child: HomePage()),
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
          // Admin pages - no layout wrapper
          GetPage(
            name: AppRoute.admin,
            page: () => const AdminDashboardPage(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.adminNew,
            page: () => const CreateProjectPage(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoute.editProject,
            page: () => const EditProjectPage(),
            transition: Transition.fadeIn,
          ),
        ],
      ),
    );
  }
}

