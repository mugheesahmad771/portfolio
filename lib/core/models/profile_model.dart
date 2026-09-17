class ProfileModel {
  final String name;
  final String title;
  final String tagline;
  final String availability;
  final List<String> specialization;
  final String github;
  final String linkedin;
  final String relocation;

  ProfileModel({
    required this.name,
    required this.title,
    required this.tagline,
    required this.availability,
    required this.specialization,
    required this.github,
    required this.linkedin,
    required this.relocation,
  });

  factory ProfileModel.demo() {
    return ProfileModel(
      name: 'Mughees Ahmad',
      title:
          'Flutter Developer • Full-Stack Mobile & Backend Engineer • AI-Enabled Solutions',
      tagline:
          '3+ years building production Flutter, React Native, Angular and ASP.NET Core applications — with AI-powered features and intelligent automation along the way.',
      availability: 'Available for select remote roles',
      specialization: ['Flutter', 'React Native', 'Angular', 'ASP.NET Core'],
      github: 'https://github.com/mugheesahmad771',
      linkedin: 'https://www.linkedin.com/in/mughees-ahmad-977105414/',
      relocation:
          'Open to relocation for the right opportunity and compensation.',
    );
  }
}
