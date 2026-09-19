import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/api_client/main_client.dart';
import 'package:portfolio/core/models/audit_log_model.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/services/audit_log_service.dart';
import 'package:portfolio/services/auth_service.dart';
import 'package:portfolio/services/contact_service.dart';
import 'package:portfolio/services/experience_service.dart';
import 'package:portfolio/services/project_service.dart';

enum AdminTab { projects, experience, messages, auditLog }

class AdminViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ProjectService projectService = Get.find<ProjectService>();
  final ExperienceService experienceService = Get.find<ExperienceService>();
  final ContactService contactService = Get.find<ContactService>();
  final AuditLogService auditLogService = Get.find<AuditLogService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController projectSearchController =
      TextEditingController();

  static const int projectPageSize = 10;

  final _projects = <ProjectModel>[].obs;
  final _experiences = <ExperienceModel>[].obs;
  final _messages = <Map<String, dynamic>>[].obs;
  final _auditLogs = <AuditLogModel>[].obs;
  final _tab = AdminTab.projects.obs;
  final _isLoading = false.obs;
  final _isLoggingIn = false.obs;
  final _loginError = ''.obs;
  final _isChangingPassword = false.obs;
  final _changePasswordError = ''.obs;
  final _projectPage = 1.obs;
  final _projectTotalCount = 0.obs;
  final _isProjectsRefreshing = false.obs;
  final _isSyncingSeed = false.obs;
  final _isSyncingImages = false.obs;
  Timer? _projectSearchDebounce;

  List<ProjectModel> get projects => _projects;
  List<ExperienceModel> get experiences => _experiences;
  List<Map<String, dynamic>> get messages => _messages;
  List<AuditLogModel> get auditLogs => _auditLogs;
  AdminTab get tab => _tab.value;
  bool get isLoading => _isLoading.value;
  bool get isLoggingIn => _isLoggingIn.value;
  String get loginError => _loginError.value;
  bool get isChangingPassword => _isChangingPassword.value;
  String get changePasswordError => _changePasswordError.value;
  int get projectPage => _projectPage.value;
  int get projectTotalCount => _projectTotalCount.value;
  int get projectPageCount =>
      (_projectTotalCount.value / projectPageSize).ceil().clamp(1, 999999);
  bool get isProjectsRefreshing => _isProjectsRefreshing.value;
  bool get isSyncingSeed => _isSyncingSeed.value;
  bool get isSyncingImages => _isSyncingImages.value;

  @override
  void onInit() {
    super.onInit();
    if (authService.isAuthenticated) _loadAll();
  }

  void setTab(AdminTab value) {
    _tab.value = value;
    if (value == AdminTab.messages && _messages.isEmpty) _loadMessages();
    if (value == AdminTab.auditLog && _auditLogs.isEmpty) _loadAuditLogs();
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
      await _loadProjectsPage();
      _experiences.value = await experienceService.getAll();
    } catch (_) {
      // Leave lists empty; the panel still renders with empty-state UI.
    }
    _isLoading.value = false;
    update();
  }

  Future<void> _loadProjectsPage() async {
    final result = await projectService.getPage(
      search: projectSearchController.text,
      page: _projectPage.value,
      pageSize: projectPageSize,
    );
    _projects.value = result.items;
    _projectTotalCount.value = result.totalCount;
  }

  /// Debounced so a search box doesn't fire a request per keystroke.
  void searchProjects(String query) {
    _projectSearchDebounce?.cancel();
    _projectSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      _projectPage.value = 1;
      _loadProjectsPage().then((_) => update());
    });
  }

  void setProjectPage(int page) {
    if (page < 1 || page > projectPageCount || page == _projectPage.value) {
      return;
    }
    _projectPage.value = page;
    _loadProjectsPage().then((_) => update());
  }

  /// Manual reload of the current page/search — a dedicated loading flag so
  /// the refresh control can show its own spinner without blanking the
  /// whole tab the way the initial [_isLoading] state does.
  Future<void> refreshProjects() async {
    _isProjectsRefreshing.value = true;
    update();
    try {
      await _loadProjectsPage();
    } catch (_) {
      // Keep whatever was already showing rather than clearing it on a
      // failed refresh.
    }
    _isProjectsRefreshing.value = false;
    update();
  }

  /// Returns the slugs actually added, so the caller can show what
  /// happened (including the "nothing to add" case) rather than a generic
  /// success toast.
  Future<List<String>> syncSeedProjects() async {
    _isSyncingSeed.value = true;
    update();
    List<String> added = [];
    try {
      added = await projectService.syncSeedProjects();
      if (added.isNotEmpty) await _loadProjectsPage();
    } finally {
      _isSyncingSeed.value = false;
      update();
    }
    return added;
  }

  /// Returns the slugs actually updated, so the caller can show what
  /// happened (including the "nothing to update" case) rather than a
  /// generic success toast.
  Future<List<String>> syncProjectImages() async {
    _isSyncingImages.value = true;
    update();
    List<String> updated = [];
    try {
      updated = await projectService.syncProjectImages();
      if (updated.isNotEmpty) await _loadProjectsPage();
    } finally {
      _isSyncingImages.value = false;
      update();
    }
    return updated;
  }

  /// Reloads whatever tab is currently open — the single entry point for
  /// both the pull-to-refresh gesture (works the same via touch or mouse
  /// drag, so it needs no per-platform branching) and any other "refresh
  /// this" trigger that isn't specific to the Projects tab's own button.
  Future<void> refreshCurrentTab() async {
    switch (_tab.value) {
      case AdminTab.projects:
        await refreshProjects();
        break;
      case AdminTab.experience:
        try {
          _experiences.value = await experienceService.getAll();
        } catch (_) {
          // Keep whatever was already showing rather than clearing it.
        }
        update();
        break;
      case AdminTab.messages:
        await _loadMessages();
        update();
        break;
      case AdminTab.auditLog:
        await _loadAuditLogs();
        break;
    }
  }

  Future<void> _loadMessages() async {
    try {
      _messages.value = await contactService.getSubmissions();
    } catch (_) {
      _messages.value = [];
    }
  }

  Future<void> _loadAuditLogs() async {
    try {
      _auditLogs.value = await auditLogService.getAll();
    } catch (_) {
      _auditLogs.value = [];
    }
    update();
  }

  Future<void> deleteProject(String id) async {
    await projectService.delete(id);
    // Deleting the last item on a page beyond the first would otherwise
    // strand the view on a now-empty page.
    if (_projects.length == 1 && _projectPage.value > 1) {
      _projectPage.value -= 1;
    }
    await _loadProjectsPage();
    update();
  }

  Future<void> toggleFeatured(String projectId) async {
    final matches = _projects.where((p) => p.id == projectId);
    if (matches.isEmpty) return;
    final project = matches.first;
    await projectService.update(project.copyWith(featured: !project.featured));
    await _loadProjectsPage();
    update();
  }

  Future<void> deleteExperience(String id) async {
    await experienceService.delete(id);
    _experiences.value = await experienceService.getAll();
  }

  void openChangePasswordDialog() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    _changePasswordError.value = '';
    update();
  }

  /// Returns true on success. The backend revokes every refresh token on a
  /// successful change, so [AuthService.changePassword] also signs this
  /// session out — the caller should route back to the login screen.
  Future<bool> submitChangePassword() async {
    final current = currentPasswordController.text;
    final next = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      _changePasswordError.value = 'All fields are required.';
      update();
      return false;
    }
    if (next.length < 8) {
      _changePasswordError.value =
          'New password must be at least 8 characters.';
      update();
      return false;
    }
    if (next != confirm) {
      _changePasswordError.value = 'New password and confirmation do not match.';
      update();
      return false;
    }

    _isChangingPassword.value = true;
    _changePasswordError.value = '';
    update();
    try {
      await authService.changePassword(
        currentPassword: current,
        newPassword: next,
      );
      _projects.clear();
      _experiences.clear();
      _messages.clear();
      _auditLogs.clear();
      _projectPage.value = 1;
      _projectTotalCount.value = 0;
      projectSearchController.clear();
      emailController.clear();
      passwordController.clear();
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      _isChangingPassword.value = false;
      update();
      return true;
    } on ApiException catch (e) {
      _changePasswordError.value = e.message;
    } catch (_) {
      _changePasswordError.value = 'Something went wrong. Please try again.';
    }
    _isChangingPassword.value = false;
    update();
    return false;
  }

  void logout() {
    authService.logout();
    _projects.clear();
    _experiences.clear();
    _messages.clear();
    _auditLogs.clear();
    _projectPage.value = 1;
    _projectTotalCount.value = 0;
    projectSearchController.clear();
    emailController.clear();
    passwordController.clear();
    update();
  }

  @override
  void onClose() {
    _projectSearchDebounce?.cancel();
    emailController.dispose();
    passwordController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    projectSearchController.dispose();
    super.onClose();
  }
}
