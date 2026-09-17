import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/core/utils/resume_download.dart';
import 'package:portfolio/pages/skills/viewmodel/skills_viewmodel.dart';
import 'package:portfolio/services/experience_service.dart';

class ResumeViewModel extends GetxController {
  final ExperienceService _experienceService = Get.find<ExperienceService>();

  final Map<String, dynamic> resumeData = {
    'contact': {
      'email': 'mugheesahmad771@gmail.com',
      'phone': '+92 318 6361580',
      'location': 'Multan, Pakistan',
      'website': 'github.com/mugheesahmad771',
    },
    'summary':
        'Flutter Developer with 3+ years of professional experience building high-quality, cross-platform mobile applications for iOS and Android. Full-stack experience across React Native, Angular 18+ and C# ASP.NET Web API, with hands-on work in AI-powered features and intelligent automation.',
  };

  List<ExperienceModel> experiences = [];
  final List<SkillGroup> skillGroups = kSkillGroups;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading = true;
    update();
    try {
      experiences = await _experienceService.getAll();
    } catch (_) {
      // Keep the resume page usable even if the network call fails.
    }
    isLoading = false;
    update();
  }

  Future<void> downloadResume() => downloadResumePdf();
}
