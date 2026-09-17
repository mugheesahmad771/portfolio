import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/auth_service.dart';
import 'package:portfolio/services/contact_service.dart';
import 'package:portfolio/services/experience_service.dart';
import 'package:portfolio/services/project_service.dart';

enum AdminTab { projects, experience, messages }

class AdminViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ProjectService projectService = Get.find<ProjectService>();
  final ExperienceService experienceService = Get.find<ExperienceService>();
  final ContactService contactService = Get.find<ContactService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _projects = <ProjectModel>[].obs;
  final _experiences = <ExperienceModel>[].obs;
  final _messages = <Map<String, dynamic>>[].obs;
  final _tab = AdminTab.projects.obs;
  final _isLoading = false.obs;
  final _isLoggingIn = false.obs;
  final _loginError = ''.obs;

  List<ProjectModel> get projects => _projects;
  List<ExperienceModel> get experiences => _experiences;
  List<Map<String, dynamic>> get messages => _messages;
  AdminTab get tab => _tab.value;
  bool get isLoading => _isLoading.value;
  bool get isLoggingIn => _isLoggingIn.value;
  String get loginError => _loginError.value;

  @override
  void onInit() {
    super.onInit();
    if (authService.isAuthenticated) _loadAll();
  }

  void setTab(AdminTab value) {
    _tab.value = value;
    if (value == AdminTab.messages && _messages.isEmpty) _loadMessages();
    update();
  }

  Future<bool> login(String email, String password) async {
    _isLoggingIn.value = true;
    _loginError.value = '';
    update();
    final success = await authService.login(email, password);
    if (success) {
      await _loadAll();
    } else {
      _loginError.value = authService.lastError ?? 'Invalid email or password.';
    }
    _isLoggingIn.value = false;
    update();
    return success;
  }

  /// Reads [emailController]/[passwordController] and attempts login, so the
  /// view never needs its own local state for the submit action.
  Future<void> submitLogin() =>
      login(emailController.text.trim(), passwordController.text);

  Future<void> _loadAll() async {
    _isLoading.value = true;
    update();
    try {
      _projects.value = await projectService.getAll();
      _experiences.value = await experienceService.getAll();
    } catch (_) {
      // Leave lists empty; the panel still renders with empty-state UI.
    }
    _isLoading.value = false;
    update();
  }

  Future<void> _loadMessages() async {
    try {
      _messages.value = await contactService.getSubmissions();
    } catch (_) {
      _messages.value = [];
    }
  }

  Future<void> deleteProject(String id) async {
    await projectService.delete(id);
    _projects.value = await projectService.getAll();
  }

  Future<void> toggleFeatured(String projectId) async {
    final matches = _projects.where((p) => p.id == projectId);
    if (matches.isEmpty) return;
    final project = matches.first;
    await projectService.update(project.copyWith(featured: !project.featured));
    _projects.value = await projectService.getAll();
  }

  Future<void> deleteExperience(String id) async {
    await experienceService.delete(id);
    _experiences.value = await experienceService.getAll();
  }

  void logout() {
    authService.logout();
    _projects.clear();
    _experiences.clear();
    _messages.clear();
    emailController.clear();
    passwordController.clear();
    update();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
