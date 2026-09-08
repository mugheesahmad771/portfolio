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
      title: 'Full Stack Developer & Creative Technologist',
      tagline:
          'Crafting digital experiences with cutting-edge technologies. Specialized in building responsive, scalable applications from concept to production.',
      availability: 'Open to Opportunities',
      specialization: [
        'Flutter',
        'React',
        'Node.js',
        'TypeScript',
        'Firebase',
        'REST APIs'
      ],
      github: 'https://github.com/mugheesahmad771',
      linkedin: 'https://linkedin.com/in/mugheesahmad',
      relocation: 'Available for remote and in-office opportunities worldwide.',
    );
  }
}
