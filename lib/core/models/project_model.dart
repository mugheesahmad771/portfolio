class ProjectLink {
  final String label;
  final String url;

  ProjectLink({
    required this.label,
    required this.url,
  });
}

class ProjectStatistic {
  final String label;
  final String value;

  ProjectStatistic({
    required this.label,
    required this.value,
  });
}

class ProjectModel {
  final String id;
  final String slug;
  final String title;
  final String? company;
  final String? client;
  final String role;
  final String employmentType; // Full-time, Contract, Freelance, etc
  final String duration; // "2 years 3 months"
  final DateTime? startDate;
  final DateTime? endDate;
  final bool currentlyWorking;
  final String shortDescription;
  final String fullDescription; // Extended description
  final String problemStatement;
  final String solution;
  final List<String> responsibilities;
  final List<String> keyFeatures;
  final List<String> technologies;
  final List<String> platforms; // iOS, Android, Web
  final List<String> screenshots;
  final String? thumbnail;
  final String? thumbnail2;
  final String? thumbnail3;
  final String? coverImage;
  final String? githubLink;
  final String? liveLink;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final bool featured;
  final bool privateProject;
  final bool canShowScreenshots;
  final bool canShowCompanyName;
  final List<ProjectLink> links;
  final List<ProjectStatistic> statistics;

  ProjectModel({
    required this.id,
    required this.slug,
    required this.title,
    this.company,
    this.client,
    required this.role,
    this.employmentType = 'Full-time',
    this.duration = '',
    this.startDate,
    this.endDate,
    this.currentlyWorking = false,
    this.shortDescription = '',
    this.fullDescription = '',
    this.problemStatement = '',
    this.solution = '',
    this.responsibilities = const [],
    this.keyFeatures = const [],
    required this.technologies,
    this.platforms = const ['Web', 'Mobile'],
    this.screenshots = const [],
    this.thumbnail,
    this.thumbnail2,
    this.thumbnail3,
    this.coverImage,
    this.githubLink,
    this.liveLink,
    this.playStoreUrl,
    this.appStoreUrl,
    this.featured = false,
    this.privateProject = false,
    this.canShowScreenshots = true,
    this.canShowCompanyName = true,
    this.links = const [],
    this.statistics = const [],
  });

  factory ProjectModel.demo() {
    return ProjectModel(
      id: '1',
      slug: 'portfolio-website',
      title: 'Portfolio Website',
      company: 'Self',
      role: 'Full Stack Developer',
      employmentType: 'Personal Project',
      duration: '3 months',
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 4, 1),
      currentlyWorking: false,
      shortDescription: 'A modern, responsive portfolio website showcasing projects and skills.',
      fullDescription: 'A comprehensive portfolio website built with React and Flutter, featuring project showcases, experience timeline, and an admin dashboard.',
      problemStatement: 'Needed a platform to showcase portfolio projects and work experience.',
      solution: 'Built a full-stack application with React frontend, Flutter mobile, and ASP.NET Core backend.',
      responsibilities: [
        'Designed and implemented responsive UI',
        'Created project showcase system',
        'Built admin dashboard for project management',
        'Implemented authentication system'
      ],
      keyFeatures: [
        'Responsive Design',
        'Project Showcase',
        'Admin Dashboard',
        'Contact Form',
        'Dark Mode Support'
      ],
      technologies: ['React', 'TypeScript', 'Tailwind CSS', 'Flutter', 'ASP.NET Core'],
      platforms: ['Web', 'Mobile'],
      featured: true,
      privateProject: false,
      canShowScreenshots: true,
      canShowCompanyName: true,
      links: [
        ProjectLink(label: 'GitHub', url: 'https://github.com/mugheesahmad771/portfolio'),
        ProjectLink(label: 'Live Demo', url: 'https://portfolio.mugheesahmad.dev'),
      ],
      statistics: [
        ProjectStatistic(label: 'Users', value: '500+'),
        ProjectStatistic(label: 'Projects', value: '15+'),
        ProjectStatistic(label: 'Stars', value: '120'),
      ],
    );
  }

  // For JSON serialization (if needed)
  Map<String, dynamic> toJson() => {
    'id': id,
    'slug': slug,
    'title': title,
    'company': company,
    'client': client,
    'role': role,
    'employmentType': employmentType,
    'duration': duration,
    'startDate': startDate?.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'currentlyWorking': currentlyWorking,
    'shortDescription': shortDescription,
    'fullDescription': fullDescription,
    'problemStatement': problemStatement,
    'solution': solution,
    'responsibilities': responsibilities,
    'keyFeatures': keyFeatures,
    'technologies': technologies,
    'platforms': platforms,
    'screenshots': screenshots,
    'thumbnail': thumbnail,
    'coverImage': coverImage,
    'githubLink': githubLink,
    'liveLink': liveLink,
    'playStoreUrl': playStoreUrl,
    'appStoreUrl': appStoreUrl,
    'featured': featured,
    'privateProject': privateProject,
    'canShowScreenshots': canShowScreenshots,
    'canShowCompanyName': canShowCompanyName,
    'links': links.map((l) => {'label': l.label, 'url': l.url}).toList(),
    'statistics': statistics.map((s) => {'label': s.label, 'value': s.value}).toList(),
  };

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      company: json['company'],
      client: json['client'],
      role: json['role'] ?? '',
      employmentType: json['employmentType'] ?? 'Full-time',
      duration: json['duration'] ?? '',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      currentlyWorking: json['currentlyWorking'] ?? false,
      shortDescription: json['shortDescription'] ?? '',
      fullDescription: json['fullDescription'] ?? '',
      problemStatement: json['problemStatement'] ?? '',
      solution: json['solution'] ?? '',
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      keyFeatures: List<String>.from(json['keyFeatures'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      platforms: List<String>.from(json['platforms'] ?? ['Web', 'Mobile']),
      screenshots: List<String>.from(json['screenshots'] ?? []),
      thumbnail: json['thumbnail'],
      coverImage: json['coverImage'],
      githubLink: json['githubLink'],
      liveLink: json['liveLink'],
      playStoreUrl: json['playStoreUrl'],
      appStoreUrl: json['appStoreUrl'],
      featured: json['featured'] ?? false,
      privateProject: json['privateProject'] ?? false,
      canShowScreenshots: json['canShowScreenshots'] ?? true,
      canShowCompanyName: json['canShowCompanyName'] ?? true,
      links: (json['links'] as List?)?.map((l) => ProjectLink(label: l['label'], url: l['url'])).toList() ?? [],
      statistics: (json['statistics'] as List?)?.map((s) => ProjectStatistic(label: s['label'], value: s['value'])).toList() ?? [],
    );
  }
}
