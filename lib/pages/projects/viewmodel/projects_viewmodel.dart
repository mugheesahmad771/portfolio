import 'package:get/get.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/project_service.dart';

class ProjectsViewModel extends GetxController {
  final ProjectService projectService = ProjectService();

  late List<ProjectModel> allProjects;
  final _filteredProjects = <ProjectModel>[].obs;
  final _selectedCategory = 'All'.obs;
  final _searchQuery = ''.obs;

  List<ProjectModel> get filteredProjects => _filteredProjects;
  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;

  final List<String> categories = [
    'All',
    'Mobile',
    'Web',
    'Backend',
    'Full Stack'
  ];

  @override
  void onInit() {
    super.onInit();
    _loadProjects();
  }

  void _loadProjects() {
    allProjects = projectService.getAll();
    _filterProjects();
  }

  void setCategory(String category) {
    _selectedCategory.value = category;
    _filterProjects();
  }

  void search(String query) {
    _searchQuery.value = query;
    _filterProjects();
  }

  void _filterProjects() {
    var projects = allProjects;

    // Filter by category
    if (_selectedCategory.value != 'All') {
      projects = projects
          .where((p) =>
              p.technologies
                  .any((t) => t.contains(_selectedCategory.value)) ||
              p.role.contains(_selectedCategory.value))
          .toList();
    }

    // Filter by search
    if (_searchQuery.value.isNotEmpty) {
      projects = projects
          .where((p) =>
              p.title.toLowerCase().contains(_searchQuery.value.toLowerCase()) ||
              p.shortDescription
                  .toLowerCase()
                  .contains(_searchQuery.value.toLowerCase()) ||
              p.fullDescription
                  .toLowerCase()
                  .contains(_searchQuery.value.toLowerCase()))
          .toList();
    }

    _filteredProjects.value = projects;
  }

  List<ProjectModel> getFeaturedProjects() {
    return allProjects.where((p) => p.featured).toList();
  }
}
