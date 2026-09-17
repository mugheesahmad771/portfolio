class AppRoute {
  // Public routes
  static const home = '/home';
  static const about = '/about';
  static const projects = '/projects';
  static const projectDetail = '/projects/:slug';
  static const experience = '/experience';
  static const skills = '/skills';
  static const contact = '/contact';
  static const resume = '/resume';

  // Admin routes
  static const admin = '/admin';
  static const projectForm = '/admin/projects/form';
  static const projectFormEdit = '/admin/projects/form/:id';
  static const adminExperienceForm = '/admin/experience/form';
  static const adminExperienceFormEdit = '/admin/experience/form/:id';
}
