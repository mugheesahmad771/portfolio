import 'package:get/get.dart';

class SkillsViewModel extends GetxController {
  late List<Map<String, dynamic>> skills;

  @override
  void onInit() {
    super.onInit();
    _loadSkills();
  }

  void _loadSkills() {
    skills = [
      {'name': 'Flutter', 'level': 95, 'category': 'Mobile'},
      {'name': 'React', 'level': 90, 'category': 'Frontend'},
      {'name': 'TypeScript', 'level': 88, 'category': 'Language'},
      {'name': 'Node.js', 'level': 87, 'category': 'Backend'},
      {'name': 'Firebase', 'level': 85, 'category': 'Backend'},
      {'name': 'PostgreSQL', 'level': 82, 'category': 'Database'},
      {'name': 'GraphQL', 'level': 80, 'category': 'Architecture'},
      {'name': 'REST APIs', 'level': 90, 'category': 'Architecture'},
      {'name': 'Git', 'level': 92, 'category': 'Tools'},
      {'name': 'Docker', 'level': 75, 'category': 'DevOps'},
      {'name': 'AWS', 'level': 78, 'category': 'Cloud'},
      {'name': 'Figma', 'level': 70, 'category': 'Design'},
    ];
  }

  List<String> getCategories() {
    return skills.map((s) => s['category'] as String).toSet().toList();
  }

  List<Map<String, dynamic>> getSkillsByCategory(String category) {
    return skills.where((s) => s['category'] == category).toList();
  }
}
