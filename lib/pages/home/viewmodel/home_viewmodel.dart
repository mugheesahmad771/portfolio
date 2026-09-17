import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/core/models/profile_model.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/core/models/stats_model.dart';
import 'package:portfolio/core/models/tech_stack_model.dart';
import 'package:portfolio/services/experience_service.dart';
import 'package:portfolio/services/project_service.dart';

class HomeViewModel extends GetxController {
  final ProjectService _projectService = Get.find<ProjectService>();
  final ExperienceService _experienceService = Get.find<ExperienceService>();

  final ProfileModel profile = ProfileModel.demo();
  final List<StatsModel> stats = StatsModel.all;
  final List<String> coreStack = TechStack.coreStack;

  List<ProjectModel> featuredProjects = [];
  List<ExperienceModel> experiences = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> retry() => _initializeData();

  Future<void> _initializeData() async {
    isLoading = true;
    hasError = false;
    update();
    try {
      final results = await Future.wait([
        _projectService.getFeatured(),
        _experienceService.getAll(),
      ]);
      featuredProjects = results[0] as List<ProjectModel>;
      experiences = (results[1] as List<ExperienceModel>).take(3).toList();
    } catch (_) {
      // A real fetch failure is distinct from "nothing added yet" — the
      // page shows a retry affordance rather than silently rendering an
      // empty state that looks identical to "no content".
      hasError = true;
    }
    isLoading = false;
    update();
  }

  Future<List<ProjectModel>> getAllProjects() {
    return _projectService.getAll();
  }
}
