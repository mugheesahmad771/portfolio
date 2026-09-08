import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';

class ExperienceViewModel extends GetxController {
  late List<ExperienceModel> experiences;

  @override
  void onInit() {
    super.onInit();
    _loadExperiences();
  }

  void _loadExperiences() {
    experiences = [
      ExperienceModel.demo(0),
      ExperienceModel.demo(1),
      ExperienceModel.demo(2),
    ];
  }
}
