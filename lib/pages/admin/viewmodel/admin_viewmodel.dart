import 'package:get/get.dart';
import 'package:portfolio/services/auth_service.dart';
import 'package:portfolio/services/project_service.dart';
import 'package:portfolio/core/models/project_model.dart';

class AdminViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ProjectService projectService = ProjectService();

  final _projects = <ProjectModel>[].obs;
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _passCodeError = ''.obs;

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get passCodeError => _passCodeError.value;

  @override
  void onInit() {
    super.onInit();
    _loadProjects();
  }

  void _loadProjects() {
    _projects.value = projectService.getAll();
  }

  Future<bool> authenticate(String passcode) async {
    _isLoading.value = true;
    _passCodeError.value = '';

    final result = await authService.authenticate(passcode);

    if (result) {
      _passCodeError.value = '';
      _isLoading.value = false;
      return true;
    } else {
      _passCodeError.value = 'Invalid passcode. Please try again.';
      _isLoading.value = false;
      return false;
    }
  }

  void addProject(ProjectModel project) {
    projectService.addProject(project);
    _loadProjects();
  }

  void updateProject(ProjectModel project) {
    projectService.updateProject(project);
    _loadProjects();
  }

  void deleteProject(String id) {
    projectService.deleteProject(id);
    _loadProjects();
  }

  void toggleFeatured(String projectId) {
    final project = projectService.getById(projectId);
    if (project != null) {
      final updated = ProjectModel(
        id: project.id,
        title: project.title,
        slug: project.slug,
        shortDescription: project.shortDescription,
        fullDescription: project.fullDescription,
        thumbnail: project.thumbnail,
        thumbnail2: project.thumbnail2,
        thumbnail3: project.thumbnail3,
        role: project.role,
        technologies: project.technologies,
        featured: !project.featured,
        privateProject: project.privateProject,
        currentlyWorking: project.currentlyWorking,
        startDate: project.startDate,
        endDate: project.endDate,
        githubLink: project.githubLink,
        liveLink: project.liveLink,
      );
      updateProject(updated);
    }
  }

  void logout() {
    authService.logout();
  }
}
