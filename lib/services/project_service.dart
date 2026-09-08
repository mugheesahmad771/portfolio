import 'package:portfolio/core/models/project_model.dart';

class ProjectService {
  final List<ProjectModel> _projects = [
    ProjectModel(
      id: '1',
      title: 'E-Commerce Mobile App',
      slug: 'ecommerce-app',
      shortDescription:
          'A full-featured e-commerce application built with Flutter and Firebase.',
      fullDescription: 'Complete e-commerce solution with real-time inventory management, secure payments, and user reviews.',
      role: 'Lead Mobile Developer',
      technologies: ['Flutter', 'Firebase', 'Dart', 'GetX'],
      featured: true,
      privateProject: false,
      currentlyWorking: false,
    ),
    ProjectModel(
      id: '2',
      title: 'Portfolio Website',
      slug: 'portfolio-website',
      shortDescription: 'Modern portfolio website showcasing projects and experience.',
      fullDescription: 'Responsive portfolio built with React and TypeScript featuring project showcase, admin dashboard, and contact management.',
      role: 'Full Stack Developer',
      technologies: ['React', 'TypeScript', 'Tailwind CSS'],
      featured: true,
      privateProject: false,
      currentlyWorking: false,
    ),
    ProjectModel(
      id: '3',
      title: 'Enterprise Dashboard',
      slug: 'enterprise-dashboard',
      shortDescription: 'Real-time analytics dashboard for enterprise clients.',
      fullDescription: 'Advanced analytics platform with real-time data visualization, custom reports, and multi-user collaboration features.',
      role: 'Senior Developer',
      technologies: ['React', 'Node.js', 'PostgreSQL', 'GraphQL'],
      featured: false,
      privateProject: true,
      currentlyWorking: true,
    ),
    ProjectModel(
      id: '4',
      title: 'Social Media App',
      slug: 'social-media-app',
      shortDescription: 'Cross-platform social networking application.',
      fullDescription: 'Full-featured social platform with messaging, notifications, feeds, and community features built with Flutter and Node.js.',
      role: 'Full Stack Developer',
      technologies: ['Flutter', 'Node.js', 'MongoDB'],
      featured: false,
      privateProject: false,
      currentlyWorking: false,
    ),
  ];

  List<ProjectModel> getAll() {
    return _projects;
  }

  List<ProjectModel> getFeatured() {
    return _projects.where((p) => p.featured).toList();
  }

  ProjectModel? getById(String id) {
    try {
      return _projects.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void addProject(ProjectModel project) {
    _projects.add(project);
  }

  void updateProject(ProjectModel project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
  }
}
