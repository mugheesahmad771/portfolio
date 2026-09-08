import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/core/models/profile_model.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/core/models/stats_model.dart';
import 'package:portfolio/core/models/tech_stack_model.dart';
import 'package:portfolio/services/project_service.dart';

class HomeViewModel extends GetxController {
  final ProjectService _projectService = ProjectService();

  late ProfileModel profile;
  late List<ProjectModel> featuredProjects;
  late List<StatsModel> stats;
  late List<String> coreStack;
  late List<ExperienceModel> experiences;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Load profile
    profile = ProfileModel.demo();

    // Load featured projects
    featuredProjects = _projectService.getFeatured();

    // Load stats
    stats = [
      StatsModel(value: '50+', label: 'Projects Completed'),
      StatsModel(value: '8+', label: 'Years Experience'),
      StatsModel(value: '100%', label: 'Client Satisfaction'),
      StatsModel(value: '15+', label: 'Technologies'),
    ];

    // Load tech stack
    coreStack = TechStack.coreStack;

    // Load experiences
    experiences = [
      ExperienceModel.demo(0),
      ExperienceModel.demo(1),
      ExperienceModel.demo(2),
    ];
  }

  List<ProjectModel> getAllProjects() {
    return _projectService.getAll();
  }
}
