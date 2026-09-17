import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/services/experience_service.dart';

class ExperienceFormViewModel extends GetxController {
  final ExperienceService _experienceService = Get.find<ExperienceService>();

  ExperienceModel? _existing;
  bool get isEditing => _existing != null;

  final roleController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final durationController = TextEditingController();
  final technologiesController = TextEditingController();
  final responsibilitiesController = TextEditingController();

  final _current = false.obs;
  final _isLoading = false.obs;
  final _isSaving = false.obs;
  final _errorMessage = ''.obs;

  bool get current => _current.value;
  bool get isLoading => _isLoading.value;
  bool get isSaving => _isSaving.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    final id = Get.parameters['id'];
    if (id != null) _load(id);
  }

  Future<void> _load(String id) async {
    _isLoading.value = true;
    update();
    try {
      _existing = await _experienceService.getById(id);
      if (_existing != null) {
        roleController.text = _existing!.role;
        companyController.text = _existing!.company;
        locationController.text = _existing!.location;
        durationController.text = _existing!.duration;
        technologiesController.text = _existing!.technologies.join(', ');
        responsibilitiesController.text = _existing!.responsibilities.join(
          '\n',
        );
        _current.value = _existing!.current;
      }
    } catch (_) {
      _errorMessage.value = 'Could not load this experience entry.';
    }
    _isLoading.value = false;
    update();
  }

  void toggleCurrent() => _current.toggle();

  Future<bool> save() async {
    if (roleController.text.trim().isEmpty ||
        companyController.text.trim().isEmpty) {
      _errorMessage.value = 'Role and company are required.';
      update();
      return false;
    }
    _isSaving.value = true;
    _errorMessage.value = '';
    update();
    try {
      final model = ExperienceModel(
        id: _existing?.id ?? '',
        role: roleController.text.trim(),
        company: companyController.text.trim(),
        location: locationController.text.trim(),
        duration: durationController.text.trim(),
        current: _current.value,
        technologies: technologiesController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        responsibilities: responsibilitiesController.text
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      );
      if (isEditing) {
        await _experienceService.update(model);
      } else {
        await _experienceService.create(model);
      }
      _isSaving.value = false;
      update();
      return true;
    } catch (e) {
      _errorMessage.value = 'Failed to save. Please try again.';
      _isSaving.value = false;
      update();
      return false;
    }
  }

  @override
  void onClose() {
    roleController.dispose();
    companyController.dispose();
    locationController.dispose();
    durationController.dispose();
    technologiesController.dispose();
    responsibilitiesController.dispose();
    super.onClose();
  }
}
