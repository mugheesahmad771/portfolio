import 'package:get/get.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/project_service.dart';

class ProjectsViewModel extends GetxController {
  final ProjectService projectService = Get.find<ProjectService>();

  List<ProjectModel> allProjects = [];
  final _filteredProjects = <ProjectModel>[].obs;
  final _selectedCategory = 'All'.obs;
  final _searchQuery = ''.obs;
  final _categories = <String>['All'].obs;
  final _isLoading = true.obs;
  final _hasError = false.obs;

  List<ProjectModel> get filteredProjects => _filteredProjects;
  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  Future<void> loadProjects() async {
    _isLoading.value = true;
    _hasError.value = false;
    try {
      allProjects = await projectService.getAll();
      // Real taxonomy derived from the platforms actually present, instead
      // of the old fuzzy/broken substring match against technologies.
      final platforms = allProjects.expand((p) => p.platforms).toSet().toList()
        ..sort();
      _categories.value = ['All', ...platforms];
      _filterProjects();
    } catch (_) {
      _hasError.value = true;
    }
    _isLoading.value = false;
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

    if (_selectedCategory.value != 'All') {
      projects = projects
          .where((p) => p.platforms.contains(_selectedCategory.value))
          .toList();
    }

    if (_searchQuery.value.isNotEmpty) {
      final query = _searchQuery.value.toLowerCase();
      projects = projects
          .where(
            (p) =>
                p.title.toLowerCase().contains(query) ||
                p.shortDescription.toLowerCase().contains(query) ||
                p.fullDescription.toLowerCase().contains(query),
          )
          .toList();
    }

    _filteredProjects.value = projects;
  }

  List<ProjectModel> getFeaturedProjects() {
    return allProjects.where((p) => p.featured).toList();
  }
}
