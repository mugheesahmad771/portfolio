// Complete Profile Model matching React structure

class ExperienceModel {
  final String id;
  final String company;
  final String title;
  final String description;
  final String location;
  final String startDate;
  final String? endDate;
  final bool currentlyWorking;
  final List<String> technologies;

  ExperienceModel({
    required this.id,
    required this.company,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    this.endDate,
    this.currentlyWorking = false,
    required this.technologies,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? '',
      company: json['company'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'],
      currentlyWorking: json['currentlyWorking'] ?? false,
      technologies: List<String>.from(json['technologies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'company': company,
    'title': title,
    'description': description,
    'location': location,
    'startDate': startDate,
    'endDate': endDate,
    'currentlyWorking': currentlyWorking,
    'technologies': technologies,
  };
}

class SkillModel {
  final String category;
  final List<String> skills;

  SkillModel({
    required this.category,
    required this.skills,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      category: json['category'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category,
    'skills': skills,
  };
}

class ProfileModel {
  final String name;
  final String title;
  final String tagline;
  final String email;
  final String phone;
  final String location;
  final List<String> specialization;
  final String avatarUrl;
  final String resumeUrl;
  final String githubUrl;
  final String linkedinUrl;
  final String twitterUrl;
  final String websiteUrl;
  final String bio;
  final List<ExperienceModel> experience;
  final List<SkillModel> skills;

  ProfileModel({
    required this.name,
    required this.title,
    required this.tagline,
    required this.email,
    required this.phone,
    required this.location,
    required this.specialization,
    required this.avatarUrl,
    required this.resumeUrl,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.websiteUrl,
    required this.bio,
    required this.experience,
    required this.skills,
  });

  factory ProfileModel.demo() {
    return ProfileModel(
      name: 'Mughees Ahmad',
      title: 'Senior Full Stack Developer',
      tagline: 'Building digital experiences with modern technologies',
      email: 'mugheesahmad771@gmail.com',
      phone: '+1 (555) 123-4567',
      location: 'San Francisco, CA',
      specialization: ['Flutter', 'React Native', 'ASP.NET Core', 'Angular'],
      avatarUrl: 'https://via.placeholder.com/200',
      resumeUrl: 'https://example.com/resume.pdf',
      githubUrl: 'https://github.com/mugheesahmad771',
      linkedinUrl: 'https://linkedin.com/in/mugheesahmad771',
      twitterUrl: 'https://twitter.com/mugheesahmad771',
      websiteUrl: 'https://portfolio.mugheesahmad.dev',
      bio: 'Passionate full-stack developer with expertise in mobile and web applications. I love creating intuitive user experiences and solving complex technical challenges.',
      experience: [],
      skills: [],
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      tagline: json['tagline'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      specialization: List<String>.from(json['specialization'] ?? []),
      avatarUrl: json['avatarUrl'] ?? '',
      resumeUrl: json['resumeUrl'] ?? '',
      githubUrl: json['githubUrl'] ?? '',
      linkedinUrl: json['linkedinUrl'] ?? '',
      twitterUrl: json['twitterUrl'] ?? '',
      websiteUrl: json['websiteUrl'] ?? '',
      bio: json['bio'] ?? '',
      experience: (json['experience'] as List?)?.map((e) => ExperienceModel.fromJson(e)).toList() ?? [],
      skills: (json['skills'] as List?)?.map((s) => SkillModel.fromJson(s)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'tagline': tagline,
    'email': email,
    'phone': phone,
    'location': location,
    'specialization': specialization,
    'avatarUrl': avatarUrl,
    'resumeUrl': resumeUrl,
    'githubUrl': githubUrl,
    'linkedinUrl': linkedinUrl,
    'twitterUrl': twitterUrl,
    'websiteUrl': websiteUrl,
    'bio': bio,
    'experience': experience.map((e) => e.toJson()).toList(),
    'skills': skills.map((s) => s.toJson()).toList(),
  };
}
