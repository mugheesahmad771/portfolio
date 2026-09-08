import 'package:get/get.dart';

class ResumeViewModel extends GetxController {
  // Resume data
  late Map<String, dynamic> resumeData;

  @override
  void onInit() {
    super.onInit();
    _loadResumeData();
  }

  void _loadResumeData() {
    resumeData = {
      'contact': {
        'email': 'mughees@example.com',
        'phone': '+1 (234) 567-8900',
        'location': 'San Francisco, CA',
        'website': 'www.example.com',
        'github': 'github.com/mugheesahmad771',
      },
      'summary':
          'Full Stack Developer with 8+ years of experience building scalable applications. Specialized in Flutter, React, Node.js, and cloud technologies. Proven track record of delivering high-quality projects for startups and enterprises.',
      'downloadUrl': '/assets/resume.pdf',
    };
  }

  void downloadResume() {
    // Implement download logic
    Get.snackbar(
      'Download',
      'Resume download started...',
    );
  }
}
