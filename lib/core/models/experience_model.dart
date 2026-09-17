class ExperienceModel {
  final String id;
  final String role;
  final String company;
  final String location;
  final String duration;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> technologies;
  final List<String> responsibilities;
  final bool current;

  ExperienceModel({
    this.id = '',
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    this.startDate,
    this.endDate,
    required this.technologies,
    this.responsibilities = const [],
    this.current = false,
  });

  Map<String, dynamic> toJson() => {
    'role': role,
    'company': company,
    'location': location,
    'duration': duration,
    'startDate': startDate?.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'current': current,
    'technologies': technologies,
    'responsibilities': responsibilities,
  };

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id']?.toString() ?? '',
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      duration: json['duration'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      current: json['current'] ?? false,
      technologies: List<String>.from(json['technologies'] ?? []),
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
    );
  }
}
