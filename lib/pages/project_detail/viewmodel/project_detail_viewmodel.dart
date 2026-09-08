import 'package:get/get.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/project_service.dart';

class ProjectDetailViewModel extends GetxController {
  final ProjectService projectService = ProjectService();

  late ProjectModel project;
  final _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    final slug = Get.parameters['slug'];
    _loadProject(slug);
  }

  void _loadProject(String? slug) {
    _isLoading.value = true;
    if (slug != null) {
      final foundProject = projectService.getAll().firstWhereOrNull(
            (p) => p.slug == slug,
          );
      if (foundProject != null) {
        project = foundProject;
      }
    }
    _isLoading.value = false;
  }
}
