import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/services/experience_service.dart';

class ExperienceViewModel extends GetxController {
  final ExperienceService _experienceService = Get.find<ExperienceService>();

  List<ExperienceModel> experiences = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void onInit() {
    super.onInit();
    loadExperiences();
  }

  Future<void> loadExperiences() async {
    isLoading = true;
    hasError = false;
    update();
    try {
      experiences = await _experienceService.getAll();
    } catch (_) {
      hasError = true;
    }
    isLoading = false;
    update();
  }
}
