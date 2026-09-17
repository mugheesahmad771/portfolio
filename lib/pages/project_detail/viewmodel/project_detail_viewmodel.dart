import 'package:get/get.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/core/utils/page_meta.dart';
import 'package:portfolio/services/project_service.dart';

class ProjectDetailViewModel extends GetxController {
  final ProjectService projectService = Get.find<ProjectService>();

  ProjectModel? project;
  List<ProjectModel> relatedProjects = [];
  final _isLoading = true.obs;

  bool get isLoading => _isLoading.value;
  bool get isNotFound => !_isLoading.value && project == null;

  @override
  void onInit() {
    super.onInit();
    final slug = Get.parameters['slug'];
    _loadProject(slug);
  }

  Future<void> _loadProject(String? slug) async {
    _isLoading.value = true;
    update();
    if (slug != null) {
      try {
        final foundProject = await projectService.getBySlug(slug);
        project = foundProject;
        if (foundProject != null) {
          final all = await projectService.getAll();
          relatedProjects = all
              .where((p) => p.slug != foundProject.slug)
              .take(3)
              .toList();
          setPageMeta(
            title: '${foundProject.title} — Mughees Ahmad',
            description: foundProject.shortDescription.isNotEmpty
                ? foundProject.shortDescription
                : foundProject.fullDescription,
          );
        }
      } catch (_) {
        project = null;
      }
    }
    _isLoading.value = false;
    update();
  }
}
