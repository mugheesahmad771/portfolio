import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/pages/admin/viewmodel/admin_viewmodel.dart';
import 'package:portfolio/views/app_badge.dart';
import 'package:portfolio/views/app_forms.dart';
import 'package:portfolio/views/app_tech_chip.dart';
import 'package:portfolio/views/empty_state.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminViewModel>(
      init: AdminViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            backgroundColor: AppColors.bgSecondary,
            elevation: 0,
            title: const Text(
              'MA · Admin',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.heading,
              ),
            ),
            actions: [
              if (viewModel.authService.isAuthenticated) ...[
                TextButton(
                  onPressed: () => _openChangePasswordDialog(viewModel),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: AppColors.muted),
                  ),
                ),
                TextButton(
                  onPressed: viewModel.logout,
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ],
          ),
          body: !viewModel.authService.isAuthenticated
              ? _buildLoginScreen(viewModel)
              : _buildAdminPanel(viewModel),
        );
      },
    );
  }

  Widget _buildLoginScreen(AdminViewModel viewModel) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.card,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.lock, color: AppColors.purple),
              ),
              const SizedBox(height: 20),
              const Text(
                'Private area',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.heading,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in with your admin account to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
              const SizedBox(height: 24),
              AppTextField(
                controller: viewModel.emailController,
                label: 'Email',
                hint: 'you@example.com',
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: viewModel.passwordController,
                label: 'Password',
                hint: 'Your password',
                obscureText: true,
              ),
              if (viewModel.loginError.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  viewModel.loginError,
                  style: const TextStyle(fontSize: 12, color: AppColors.red),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isLoggingIn
                      ? null
                      : viewModel.submitLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.disabled,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    viewModel.isLoggingIn ? 'Signing in...' : 'Sign In',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bg,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openChangePasswordDialog(AdminViewModel viewModel) async {
    viewModel.openChangePasswordDialog();
    final success = await Get.dialog<bool>(
      barrierDismissible: false,
      GetBuilder<AdminViewModel>(
        builder: (vm) => AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
          title: const Text(
            'Change password',
            style: TextStyle(color: AppColors.heading),
          ),
          content: SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: vm.currentPasswordController,
                  label: 'Current password',
                  hint: 'Your current password',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: vm.newPasswordController,
                  label: 'New password',
                  hint: 'At least 8 characters',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: vm.confirmPasswordController,
                  label: 'Confirm new password',
                  hint: 'Repeat new password',
                  obscureText: true,
                ),
                if (vm.changePasswordError.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    vm.changePasswordError,
                    style: const TextStyle(fontSize: 12, color: AppColors.red),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: vm.isChangingPassword
                  ? null
                  : () => Get.back(result: false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
            TextButton(
              onPressed: vm.isChangingPassword
                  ? null
                  : () async {
                      final ok = await vm.submitChangePassword();
                      if (ok) Get.back(result: true);
                    },
              child: Text(
                vm.isChangingPassword ? 'Saving...' : 'Save',
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );

    if (success == true) {
      Get.snackbar(
        'Password changed',
        'Please sign in again with your new password.',
        duration: const Duration(seconds: 3),
      );
    }
  }

  Widget _buildAdminPanel(AdminViewModel viewModel) {
    return Column(
      children: [
        _buildTabBar(viewModel),
        Expanded(
          child: viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: switch (viewModel.tab) {
                    AdminTab.projects => _buildProjectsTab(viewModel),
                    AdminTab.experience => _buildExperienceTab(viewModel),
                    AdminTab.messages => _buildMessagesTab(viewModel),
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTabBar(AdminViewModel viewModel) {
    return Container(
      color: AppColors.bgSecondary,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _tabButton(
            viewModel,
            AdminTab.projects,
            'Projects',
            Icons.folder_outlined,
          ),
          _tabButton(
            viewModel,
            AdminTab.experience,
            'Experience',
            Icons.work_outline,
          ),
          _tabButton(
            viewModel,
            AdminTab.messages,
            'Messages',
            Icons.mail_outline,
          ),
        ],
      ),
    );
  }

  Widget _tabButton(
    AdminViewModel viewModel,
    AdminTab tab,
    String label,
    IconData icon,
  ) {
    final active = viewModel.tab == tab;
    return GestureDetector(
      onTap: () => viewModel.setTab(tab),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withValues(alpha: 0.12) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: active ? AppColors.primary : AppColors.muted,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: active ? AppColors.primary : AppColors.muted,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsTab(AdminViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Projects',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Get.toNamed(AppRoute.projectForm),
            icon: const Icon(Icons.add),
            label: const Text('Create Project'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.bg,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (viewModel.projects.isEmpty)
          const EmptyState(
            icon: Icons.folder_open_outlined,
            message: 'No projects yet — create your first one above.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.projects.length,
            itemBuilder: (context, index) {
              final project = viewModel.projects[index];
              return _AdminCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      project.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.heading,
                                      ),
                                    ),
                                  ),
                                  if (project.featured || project.privateProject) ...[
                                    const SizedBox(width: 8),
                                    Wrap(
                                      spacing: 6,
                                      children: [
                                        if (project.featured)
                                          const AppBadge(
                                            label: 'Featured',
                                            showDot: false,
                                            backgroundColor: AppColors.orange,
                                          ),
                                        if (project.privateProject)
                                          const AppBadge(
                                            label: 'NDA',
                                            showDot: false,
                                            backgroundColor: AppColors.purple,
                                          ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                project.slug,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: AppColors.muted,
                              ),
                              tooltip: 'Edit',
                              onPressed: () => Get.toNamed(
                                '${AppRoute.projectForm}/${project.id}',
                              ),
                            ),
                            PopupMenuButton(
                              color: AppColors.card,
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.open_in_new,
                                        size: 18,
                                        color: AppColors.muted,
                                      ),
                                      SizedBox(width: 10),
                                      Text('View live page'),
                                    ],
                                  ),
                                  onTap: () => _openPublicPage(project.slug),
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_outline,
                                        size: 18,
                                        color: AppColors.muted,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        project.featured
                                            ? 'Unfeature'
                                            : 'Mark as Featured',
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    await viewModel.toggleFeatured(
                                      project.id,
                                    );
                                    Get.snackbar(
                                      'Updated',
                                      project.featured
                                          ? 'Removed from Featured'
                                          : 'Marked as Featured',
                                      duration: const Duration(seconds: 2),
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.delete_outline,
                                        size: 18,
                                        color: AppColors.red,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Delete',
                                        style: TextStyle(color: AppColors.red),
                                      ),
                                    ],
                                  ),
                                  onTap: () => Future.delayed(
                                    Duration.zero,
                                    () => _confirmDeleteProject(
                                      viewModel,
                                      project.id,
                                      project.title,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.technologies
                          .take(3)
                          .map((tech) => TechChip(label: tech, isSmall: true))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  /// Opens the project's public detail page in a new tab so the admin
  /// session/scroll position isn't lost.
  Future<void> _openPublicPage(String slug) async {
    final url = Uri.base.replace(path: '/projects/$slug');
    await launchUrl(url, webOnlyWindowName: '_blank');
  }

  /// Shared confirm-before-delete prompt — every destructive delete in this
  /// dashboard goes through this instead of firing immediately on tap.
  Future<bool> _confirmDelete({
    required String title,
    required String message,
  }) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text(title, style: const TextStyle(color: AppColors.heading)),
        content: Text(message, style: const TextStyle(color: AppColors.muted)),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.muted),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );
    return confirmed == true;
  }

  Future<void> _confirmDeleteProject(
    AdminViewModel viewModel,
    String id,
    String title,
  ) async {
    final ok = await _confirmDelete(
      title: 'Delete project?',
      message:
          'This removes "$title" from the public site. This cannot be undone from here.',
    );
    if (!ok) return;
    await viewModel.deleteProject(id);
    Get.snackbar(
      'Deleted',
      '"$title" was removed',
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _confirmDeleteExperience(
    AdminViewModel viewModel,
    String id,
    String role,
  ) async {
    final ok = await _confirmDelete(
      title: 'Delete experience?',
      message:
          'This removes "$role" from the public site. This cannot be undone from here.',
    );
    if (!ok) return;
    await viewModel.deleteExperience(id);
    Get.snackbar(
      'Deleted',
      '"$role" was removed',
      duration: const Duration(seconds: 2),
    );
  }

  Widget _buildExperienceTab(AdminViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => Get.toNamed(AppRoute.adminExperienceForm),
            icon: const Icon(Icons.add),
            label: const Text('Add Experience'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.bg,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (viewModel.experiences.isEmpty)
          const EmptyState(
            icon: Icons.work_outline,
            message: 'No experience entries yet — add your first role above.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.experiences.length,
            itemBuilder: (context, index) {
              final exp = viewModel.experiences[index];
              return _AdminCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp.role,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.heading,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${exp.company} · ${exp.duration}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: AppColors.muted,
                      ),
                      tooltip: 'Edit',
                      onPressed: () => Get.toNamed(
                        '${AppRoute.adminExperienceForm}/${exp.id}',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: AppColors.red,
                      ),
                      tooltip: 'Delete',
                      onPressed: () => _confirmDeleteExperience(
                        viewModel,
                        exp.id,
                        exp.role,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildMessagesTab(AdminViewModel viewModel) {
    final fmt = DateFormat('MMM d, yyyy · h:mm a');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Messages',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 24),
        if (viewModel.messages.isEmpty)
          const EmptyState(
            icon: Icons.mail_outline,
            message: "No messages yet — they'll show up here once someone "
                'reaches out.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.messages.length,
            itemBuilder: (context, index) {
              final m = viewModel.messages[index];
              DateTime? submitted;
              try {
                submitted = DateTime.parse(m['submittedAtUtc'] as String);
              } catch (_) {}
              return _AdminCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${m['name']} · ${m['email']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.heading,
                          ),
                        ),
                        if (submitted != null)
                          Text(
                            fmt.format(submitted),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.muted,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${m['message']}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.body,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

/// Shared card chrome for every row across the projects/experience/messages
/// tabs — was three copies of the same [Container]/[BoxDecoration] pair.
class _AdminCard extends StatelessWidget {
  final Widget child;
  const _AdminCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
