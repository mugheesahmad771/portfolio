class ProjectLink {
  final String label;
  final String url;

  ProjectLink({required this.label, required this.url});
}

class ProjectStatistic {
  final String label;
  final String value;

  ProjectStatistic({required this.label, required this.value});
}

/// One product within a project that ships more than one app (e.g. a
/// customer app, a driver app and an admin dashboard) — each gets its own
/// labeled, platform-tagged screenshot gallery instead of one flat list.
/// To show both an iOS and an Android gallery for the same app, add two
/// entries with the same [label] and different [platform].
class ProjectApp {
  final String label;
  final String platform;
  final List<String> screenshots;

  ProjectApp({
    required this.label,
    required this.platform,
    this.screenshots = const [],
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

  /// Link to an unlisted YouTube/Vimeo demo video — opened externally, never
  /// an uploaded video file (that would burn through free-tier storage).
  final String? videoUrl;

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

  /// Per-app breakdown for multi-app projects (e.g. Charger App's Customer
  /// App, Driver App and Admin Dashboard). Empty for single-app projects —
  /// those just use [screenshots] directly.
  final List<ProjectApp> apps;

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
    this.videoUrl,
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
    this.apps = const [],
  });

  /// Returns a copy with the given fields replaced. Use this for any
  /// partial update instead of hand-listing every field — that's exactly
  /// how a field silently goes missing (e.g. a manually-rebuilt
  /// [ProjectModel] that forgets a newly-added field like [videoUrl] or
  /// [apps], quietly wiping it out on the next save).
  ProjectModel copyWith({
    String? id,
    String? slug,
    String? title,
    String? company,
    String? client,
    String? role,
    String? employmentType,
    String? duration,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyWorking,
    String? shortDescription,
    String? fullDescription,
    String? problemStatement,
    String? solution,
    List<String>? responsibilities,
    List<String>? keyFeatures,
    List<String>? technologies,
    List<String>? platforms,
    List<String>? screenshots,
    String? thumbnail,
    String? thumbnail2,
    String? thumbnail3,
    String? coverImage,
    String? videoUrl,
    String? githubLink,
    String? liveLink,
    String? playStoreUrl,
    String? appStoreUrl,
    bool? featured,
    bool? privateProject,
    bool? canShowScreenshots,
    bool? canShowCompanyName,
    List<ProjectLink>? links,
    List<ProjectStatistic>? statistics,
    List<ProjectApp>? apps,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      company: company ?? this.company,
      client: client ?? this.client,
      role: role ?? this.role,
      employmentType: employmentType ?? this.employmentType,
      duration: duration ?? this.duration,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currentlyWorking: currentlyWorking ?? this.currentlyWorking,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      problemStatement: problemStatement ?? this.problemStatement,
      solution: solution ?? this.solution,
      responsibilities: responsibilities ?? this.responsibilities,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      technologies: technologies ?? this.technologies,
      platforms: platforms ?? this.platforms,
      screenshots: screenshots ?? this.screenshots,
      thumbnail: thumbnail ?? this.thumbnail,
      thumbnail2: thumbnail2 ?? this.thumbnail2,
      thumbnail3: thumbnail3 ?? this.thumbnail3,
      coverImage: coverImage ?? this.coverImage,
      videoUrl: videoUrl ?? this.videoUrl,
      githubLink: githubLink ?? this.githubLink,
      liveLink: liveLink ?? this.liveLink,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      featured: featured ?? this.featured,
      privateProject: privateProject ?? this.privateProject,
      canShowScreenshots: canShowScreenshots ?? this.canShowScreenshots,
      canShowCompanyName: canShowCompanyName ?? this.canShowCompanyName,
      links: links ?? this.links,
      statistics: statistics ?? this.statistics,
      apps: apps ?? this.apps,
    );
  }

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
      shortDescription:
          'A modern, responsive portfolio website showcasing projects and skills.',
      fullDescription:
          'A comprehensive portfolio website built with React and Flutter, featuring project showcases, experience timeline, and an admin dashboard.',
      problemStatement:
          'Needed a platform to showcase portfolio projects and work experience.',
      solution:
          'Built a full-stack application with React frontend, Flutter mobile, and ASP.NET Core backend.',
      responsibilities: [
        'Designed and implemented responsive UI',
        'Created project showcase system',
        'Built admin dashboard for project management',
        'Implemented authentication system',
      ],
      keyFeatures: [
        'Responsive Design',
        'Project Showcase',
        'Admin Dashboard',
        'Contact Form',
        'Dark Mode Support',
      ],
      technologies: [
        'React',
        'TypeScript',
        'Tailwind CSS',
        'Flutter',
        'ASP.NET Core',
      ],
      platforms: ['Web', 'Mobile'],
      featured: true,
      privateProject: false,
      canShowScreenshots: true,
      canShowCompanyName: true,
      links: [
        ProjectLink(
          label: 'GitHub',
          url: 'https://github.com/mugheesahmad771/portfolio',
        ),
        ProjectLink(
          label: 'Live Demo',
          url: 'https://portfolio.mugheesahmad.dev',
        ),
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
    'statistics': statistics
        .map((s) => {'label': s.label, 'value': s.value})
        .toList(),
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
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
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
      links:
          (json['links'] as List?)
              ?.map((l) => ProjectLink(label: l['label'], url: l['url']))
              .toList() ??
          [],
      statistics:
          (json['statistics'] as List?)
              ?.map(
                (s) => ProjectStatistic(label: s['label'], value: s['value']),
              )
              .toList() ??
          [],
    );
  }
}
