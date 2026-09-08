class ExperienceModel {
  final String role;
  final String company;
  final String location;
  final String duration;
  final List<String> technologies;
  final bool current;

  ExperienceModel({
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    required this.technologies,
    this.current = false,
  });

  factory ExperienceModel.demo(int index) {
    final experiences = [
      ExperienceModel(
        role: 'Senior Flutter Developer',
        company: 'Tech Company',
        location: 'Remote',
        duration: '2023 - Present',
        technologies: ['Flutter', 'Dart', 'Firebase'],
        current: true,
      ),
      ExperienceModel(
        role: 'Full Stack Developer',
        company: 'Startup Inc',
        location: 'New York',
        duration: '2021 - 2023',
        technologies: ['React', 'Node.js', 'PostgreSQL'],
        current: false,
      ),
      ExperienceModel(
        role: 'Junior Developer',
        company: 'Digital Agency',
        location: 'London',
        duration: '2019 - 2021',
        technologies: ['JavaScript', 'HTML', 'CSS'],
        current: false,
      ),
    ];
    return experiences[index % experiences.length];
  }
}
