import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/project_form/viewmodel/project_form_viewmodel.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_forms.dart';
import 'package:portfolio/views/responsive_layout.dart';

class ProjectFormPage extends StatelessWidget {
  const ProjectFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectFormViewModel>(
      init: ProjectFormViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            backgroundColor: AppColors.bgSecondary,
            elevation: 0,
            title: Text(
              viewModel.isEditing ? 'Edit Project' : 'Create Project',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.heading,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                        child: ResponsiveContainer(
                          padding: EdgeInsets.zero,
                          child: Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _FormSection(
                                  icon: Icons.info_outline,
                                  title: 'Basic Info',
                                  children: [
                                    AppTextField(
                                      controller: viewModel.titleController,
                                      label: 'Title',
                                      hint: 'Project title',
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller: viewModel.slugController,
                                      label: 'Slug',
                                      hint: 'project-slug',
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller: viewModel.roleController,
                                      label: 'Your Role',
                                      hint: 'e.g. Flutter Developer',
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppTextField(
                                            controller:
                                                viewModel.companyController,
                                            label: 'Company',
                                            hint: 'Company name',
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: AppTextField(
                                            controller:
                                                viewModel.clientController,
                                            label: 'Client',
                                            hint: 'Client name (optional)',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    _employmentTypeField(viewModel),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.durationController,
                                      label: 'Duration',
                                      hint: 'e.g. 6 months',
                                    ),
                                    const SizedBox(height: 16),
                                    _datesRow(context, viewModel),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => AppCheckbox(
                                        value: viewModel.currentlyWorking,
                                        onChanged: (v) => viewModel
                                            .setCurrentlyWorking(v ?? false),
                                        label: 'Currently working on this',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.description_outlined,
                                  title: 'Description',
                                  children: [
                                    AppTextField(
                                      controller: viewModel
                                          .shortDescriptionController,
                                      label: 'Short Description',
                                      hint: 'One-line summary for cards',
                                      maxLines: 2,
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.fullDescriptionController,
                                      label: 'Full Description (Overview)',
                                      hint: 'Detailed overview',
                                      maxLines: 4,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.problemStatementController,
                                      label: 'Problem Statement',
                                      hint: 'What problem did this solve?',
                                      maxLines: 3,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.solutionController,
                                      label: 'Solution',
                                      hint: 'How was it solved?',
                                      maxLines: 3,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller: viewModel
                                          .responsibilitiesController,
                                      label: 'Responsibilities',
                                      hint: 'One per line',
                                      maxLines: 4,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.keyFeaturesController,
                                      label: 'Key Features',
                                      hint: 'One per line',
                                      maxLines: 4,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.code_rounded,
                                  title: 'Technology & Platforms',
                                  children: [
                                    AppTextField(
                                      controller:
                                          viewModel.technologiesController,
                                      label: 'Technologies',
                                      hint:
                                          'Comma-separated: Flutter, GetX, ...',
                                      maxLines: 2,
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Platforms',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.heading,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Obx(
                                      () => Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: kAllPlatforms.map((p) {
                                          final selected = viewModel
                                              .selectedPlatforms
                                              .contains(p);
                                          return _platformChip(
                                            label: p,
                                            selected: selected,
                                            onTap: () => viewModel
                                                .togglePlatform(
                                                  p,
                                                  !selected,
                                                ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.image_outlined,
                                  title: 'Media',
                                  children: [
                                    _imagePicker(
                                      viewModel,
                                      label: 'Thumbnail',
                                      url: viewModel.thumbnail,
                                      isUploading:
                                          viewModel.isUploadingThumbnail,
                                      onPick: viewModel.pickThumbnail,
                                    ),
                                    const SizedBox(height: 20),
                                    _imagePicker(
                                      viewModel,
                                      label: 'Cover Image',
                                      url: viewModel.coverImage,
                                      isUploading: viewModel.isUploadingCover,
                                      onPick: viewModel.pickCoverImage,
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.screenshotsController,
                                      label: 'Screenshot URLs',
                                      hint: 'One URL per line',
                                      maxLines: 3,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'For a single-app project. If this '
                                      'project has more than one app, leave '
                                      'this empty and use the Apps section '
                                      'below instead.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.muted,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.videoUrlController,
                                      label: 'Demo Video URL',
                                      hint:
                                          'An unlisted YouTube/Vimeo link — '
                                          "don't upload a video file here",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.apps_outlined,
                                  title: 'Apps',
                                  subtitle:
                                      'Only for projects with more than one '
                                      'app (e.g. Charger App\'s Customer App, '
                                      'Driver App and Admin Dashboard) — each '
                                      'gets its own labeled, platform-tagged '
                                      'gallery. Add the same label twice with '
                                      'different platforms to show both iOS '
                                      'and Android for one app. Leave empty '
                                      'for a single-app project.',
                                  children: [_appsEditor(viewModel)],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.link,
                                  title: 'Links',
                                  children: [
                                    AppTextField(
                                      controller:
                                          viewModel.githubLinkController,
                                      label: 'GitHub Link',
                                      hint: 'https://github.com/...',
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.liveLinkController,
                                      label: 'Live URL',
                                      hint: 'https://...',
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.playStoreUrlController,
                                      label: 'Play Store URL',
                                      hint: 'https://play.google.com/...',
                                    ),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller:
                                          viewModel.appStoreUrlController,
                                      label: 'App Store URL',
                                      hint: 'https://apps.apple.com/...',
                                    ),
                                    const SizedBox(height: 16),
                                    _linksEditor(viewModel),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.bar_chart_outlined,
                                  title: 'Statistics',
                                  children: [_statsEditor(viewModel)],
                                ),
                                const SizedBox(height: 20),

                                _FormSection(
                                  icon: Icons.visibility_outlined,
                                  title: 'Visibility',
                                  subtitle:
                                      'Controls what shows up publicly for this project',
                                  children: [
                                    Obx(
                                      () => _visibilityToggle(
                                        icon: Icons.star_outline,
                                        color: AppColors.orange,
                                        title: 'Featured',
                                        subtitle:
                                            'Show this project in the Featured section on the homepage',
                                        value: viewModel.featured,
                                        onChanged: viewModel.setFeatured,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => _visibilityToggle(
                                        icon: Icons.lock_outline,
                                        color: AppColors.purple,
                                        title: 'Private project (NDA)',
                                        subtitle:
                                            'Marks this as confidential client work and shows an NDA badge publicly',
                                        value: viewModel.privateProject,
                                        onChanged: viewModel.setPrivateProject,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => _visibilityToggle(
                                        icon: Icons.photo_outlined,
                                        color: AppColors.primary,
                                        title: 'Show screenshots',
                                        subtitle:
                                            'Display the thumbnail/cover image publicly instead of a private placeholder',
                                        value: viewModel.canShowScreenshots,
                                        onChanged:
                                            viewModel.setCanShowScreenshots,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Obx(
                                      () => _visibilityToggle(
                                        icon: Icons.business_outlined,
                                        color: AppColors.green,
                                        title: 'Show company name',
                                        subtitle:
                                            'Display the company name publicly instead of "Confidential client"',
                                        value: viewModel.canShowCompanyName,
                                        onChanged:
                                            viewModel.setCanShowCompanyName,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _bottomSaveBar(viewModel),
                  ],
                ),
        );
      },
    );
  }

  Widget _bottomSaveBar(ProjectFormViewModel viewModel) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: AppColors.bgSecondary,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1440),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.errorMessage.isNotEmpty) ...[
                  Text(
                    viewModel.errorMessage,
                    style: const TextStyle(
                      color: AppColors.red,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: viewModel.isEditing
                        ? 'Update Project'
                        : 'Create Project',
                    isLoading: viewModel.isSaving,
                    onPressed: () async {
                      final ok = await viewModel.save();
                      if (ok) {
                        Get.back();
                        Get.snackbar(
                          'Success',
                          'Project saved successfully',
                          backgroundColor: AppColors.green,
                          colorText: AppColors.bg,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _platformChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.bg,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(Icons.check, size: 14, color: AppColors.bg),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.bg : AppColors.title,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _visibilityToggle({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: value ? color.withValues(alpha: 0.08) : AppColors.bg,
          border: Border.all(
            color: value ? color.withValues(alpha: 0.4) : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _employmentTypeField(ProjectFormViewModel viewModel) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Employment Type',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: viewModel.employmentType,
                isExpanded: true,
                dropdownColor: AppColors.card,
                style: const TextStyle(color: AppColors.title),
                items: kEmploymentTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) =>
                    v != null ? viewModel.setEmploymentType(v) : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datesRow(BuildContext context, ProjectFormViewModel viewModel) {
    final fmt = DateFormat('MMM yyyy');
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _dateField(
              context,
              'Start Date',
              viewModel.startDate,
              fmt,
              (d) => viewModel.setStartDate(d),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _dateField(
              context,
              'End Date',
              viewModel.endDate,
              fmt,
              (d) => viewModel.setEndDate(d),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateField(
    BuildContext context,
    String label,
    DateTime? value,
    DateFormat fmt,
    ValueChanged<DateTime?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null ? fmt.format(value) : 'Not set',
                  style: const TextStyle(color: AppColors.title, fontSize: 13),
                ),
                if (value != null)
                  GestureDetector(
                    onTap: () => onChanged(null),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.muted,
                    ),
                  )
                else
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.muted,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _imagePicker(
    ProjectFormViewModel viewModel, {
    required String label,
    required String? url,
    required bool isUploading,
    required VoidCallback onPick,
  }) {
    final hasImage = url != null && url.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: hasImage ? AppColors.primary : AppColors.border,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasImage
                  ? Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const Icon(
                        Icons.image_not_supported,
                        color: AppColors.disabled,
                      ),
                    )
                  : const Icon(
                      Icons.image_outlined,
                      color: AppColors.disabled,
                    ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  label: isUploading
                      ? 'Uploading...'
                      : (hasImage ? 'Replace Image' : 'Choose Image'),
                  isPrimary: false,
                  isSmall: true,
                  isLoading: isUploading,
                  onPressed: onPick,
                ),
                if (hasImage) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Uploaded',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _linksEditor(ProjectFormViewModel viewModel) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(viewModel.links.length, (i) {
            final row = viewModel.links[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: row.label,
                      label: 'Label',
                      hint: 'e.g. GitHub',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: AppTextField(
                      controller: row.url,
                      label: 'URL',
                      hint: 'https://...',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.red,
                    ),
                    onPressed: () => viewModel.removeLink(i),
                  ),
                ],
              ),
            );
          }),
          AppButton(
            label: 'Add Link',
            isPrimary: false,
            isSmall: true,
            onPressed: viewModel.addLink,
          ),
        ],
      ),
    );
  }

  Widget _statsEditor(ProjectFormViewModel viewModel) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(viewModel.stats.length, (i) {
            final row = viewModel.stats[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: row.label,
                      label: 'Label',
                      hint: 'e.g. Apps delivered',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      controller: row.value,
                      label: 'Value',
                      hint: 'e.g. 3',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.red,
                    ),
                    onPressed: () => viewModel.removeStat(i),
                  ),
                ],
              ),
            );
          }),
          AppButton(
            label: 'Add Statistic',
            isPrimary: false,
            isSmall: true,
            onPressed: viewModel.addStat,
          ),
        ],
      ),
    );
  }

  Widget _appsEditor(ProjectFormViewModel viewModel) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(viewModel.apps.length, (i) {
            final row = viewModel.apps[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppTextField(
                          controller: row.label,
                          label: 'App name',
                          hint: 'e.g. Customer App',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Platform',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.heading,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: row.platform,
                                  isExpanded: true,
                                  dropdownColor: AppColors.card,
                                  style: const TextStyle(
                                    color: AppColors.title,
                                  ),
                                  items: kAllPlatforms
                                      .map(
                                        (p) => DropdownMenuItem(
                                          value: p,
                                          child: Text(p),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) => v != null
                                      ? viewModel.setAppPlatform(i, v)
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.red,
                        ),
                        onPressed: () => viewModel.removeApp(i),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: row.screenshots,
                    label: 'Screenshot URLs',
                    hint: 'One URL per line',
                    maxLines: 3,
                  ),
                ],
              ),
            );
          }),
          AppButton(
            label: 'Add App',
            isPrimary: false,
            isSmall: true,
            onPressed: viewModel.addApp,
          ),
        ],
      ),
    );
  }
}

/// Card wrapper shared by every section of this form — an icon-labeled
/// header over a bordered card, replacing the old flat wall of fields with
/// only a colored text label between groups.
class _FormSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const _FormSection({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.heading,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 44),
              child: Text(
                subtitle!,
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ),
          ],
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
