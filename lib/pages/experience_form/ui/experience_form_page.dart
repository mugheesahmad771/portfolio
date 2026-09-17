import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/experience_form/viewmodel/experience_form_viewmodel.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_forms.dart';
import 'package:portfolio/views/responsive_layout.dart';

class ExperienceFormPage extends StatelessWidget {
  const ExperienceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExperienceFormViewModel>(
      init: ExperienceFormViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            backgroundColor: AppColors.bgSecondary,
            elevation: 0,
            title: Text(
              viewModel.isEditing ? 'Edit Experience' : 'Add Experience',
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
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ResponsiveContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.roleController,
                          label: 'Role',
                          hint: 'e.g. Senior Flutter Developer',
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.companyController,
                          label: 'Company',
                          hint: 'Company name',
                          isRequired: true,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.locationController,
                          label: 'Location',
                          hint: 'e.g. Multan, Pakistan',
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.durationController,
                          label: 'Duration',
                          hint: 'e.g. 2021 — Present',
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.technologiesController,
                          label: 'Technologies',
                          hint: 'Comma-separated: Flutter, GetX, ...',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.responsibilitiesController,
                          label: 'Responsibilities',
                          hint: 'One per line',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => AppCheckbox(
                            value: viewModel.current,
                            onChanged: (_) => viewModel.toggleCurrent(),
                            label: 'Currently working here',
                          ),
                        ),
                        if (viewModel.errorMessage.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            viewModel.errorMessage,
                            style: const TextStyle(
                              color: AppColors.red,
                              fontSize: 13,
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            label: viewModel.isEditing
                                ? 'Update Experience'
                                : 'Create Experience',
                            isLoading: viewModel.isSaving,
                            onPressed: () async {
                              final ok = await viewModel.save();
                              if (ok) {
                                Get.back();
                                Get.snackbar(
                                  'Success',
                                  'Experience saved successfully',
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
