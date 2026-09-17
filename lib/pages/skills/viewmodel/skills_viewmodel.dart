import 'package:get/get.dart';

class SkillGroup {
  final String category;
  final List<String> skills;
  SkillGroup(this.category, this.skills);
}

/// Verified skill groupings — shared data, not tied to controller lifecycle
/// so other pages (e.g. Resume) can reuse it without instantiating a
/// [GetxController] outside of GetX's dependency system.
final List<SkillGroup> kSkillGroups = [
  SkillGroup('Mobile', [
    'Flutter',
    'Dart',
    'GetX (Advanced)',
    'Provider',
    'Bloc',
    'Android',
    'iOS',
  ]),
  SkillGroup('Frontend', [
    'Angular 18+',
    'TypeScript',
    'JavaScript',
    'HTML5',
    'CSS3',
    'React Native',
  ]),
  SkillGroup('Backend / API', [
    'C# (.NET)',
    'ASP.NET Web API',
    'REST APIs',
    'JSON',
    'HTTP / Dio',
  ]),
  SkillGroup('Data & Cloud', ['Firebase', 'SQL Server', 'SQLite']),
  SkillGroup('AI / Automation', [
    'AI-powered features',
    'ML integrations',
    'Intelligent automation',
  ]),
  SkillGroup('Tools & Practice', [
    'Git',
    'GitHub',
    'Postman',
    'VS Code',
    'Visual Studio',
    'Agile/Scrum',
  ]),
];

class SkillsViewModel extends GetxController {
  final List<SkillGroup> skillGroups = kSkillGroups;
}
