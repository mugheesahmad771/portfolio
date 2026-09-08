import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/project_service.dart';

class EditProjectViewModel extends GetxController {
  final ProjectService projectService = ProjectService();

  late ProjectModel? project;
  final _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  late final nameController = TextEditingController();
  late final slugController = TextEditingController();
  late final descriptionController = TextEditingController();
  late final roleController = TextEditingController();
  late final technologiesController = TextEditingController();

  final _isFeatured = false.obs;
  final _isPrivate = false.obs;
  final _isCurrentlyWorking = false.obs;

  bool get isFeatured => _isFeatured.value;
  bool get isPrivate => _isPrivate.value;
  bool get isCurrentlyWorking => _isCurrentlyWorking.value;

  @override
  void onInit() {
    super.onInit();
    final id = Get.parameters['id'];
    _loadProject(id);
  }

  void _loadProject(String? id) {
    _isLoading.value = true;
    if (id != null) {
      project = projectService.getById(id);
      if (project != null) {
        nameController.text = project!.title;
        slugController.text = project!.slug;
        descriptionController.text = project!.shortDescription.isNotEmpty ? project!.shortDescription : project!.fullDescription;
        roleController.text = project!.role;
        technologiesController.text = project!.technologies.join(', ');
        _isFeatured.value = project!.featured;
        _isPrivate.value = project!.privateProject;
        _isCurrentlyWorking.value = project!.currentlyWorking;
      }
    }
    _isLoading.value = false;
  }

  void toggleFeatured() => _isFeatured.toggle();
  void togglePrivate() => _isPrivate.toggle();
  void toggleCurrentlyWorking() => _isCurrentlyWorking.toggle();

  Future<void> updateProject() async {
    final technologies = technologiesController.text
        .split(',')
        .map((t) => t.trim())
        .toList();

    final updated = ProjectModel(
      id: project!.id,
      title: nameController.text,
      slug: slugController.text,
      shortDescription: descriptionController.text,
      fullDescription: descriptionController.text,
      role: roleController.text,
      technologies: technologies,
      featured: _isFeatured.value,
      privateProject: _isPrivate.value,
      currentlyWorking: _isCurrentlyWorking.value,
    );

    projectService.updateProject(updated);
    Get.back();
    Get.snackbar(
      'Success',
      'Project updated successfully',
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    slugController.dispose();
    descriptionController.dispose();
    roleController.dispose();
    technologiesController.dispose();
    super.onClose();
  }
}
