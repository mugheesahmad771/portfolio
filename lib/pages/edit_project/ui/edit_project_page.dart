import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/edit_project/viewmodel/edit_project_viewmodel.dart';
import 'package:portfolio/views/app_forms.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/responsive_layout.dart';

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProjectViewModel>(
      init: EditProjectViewModel(),
      builder: (viewModel) {
        if (viewModel.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.bg,
            body: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            backgroundColor: AppColors.bgSecondary,
            elevation: 0,
            title: const Text(
              'Edit Project',
              style: TextStyle(
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: viewModel.nameController,
                    label: 'Project Title',
                    hint: 'Project name',
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
                    controller: viewModel.descriptionController,
                    label: 'Description',
                    hint: 'Project description',
                    maxLines: 3,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: viewModel.roleController,
                    label: 'Your Role',
                    hint: 'Your role in this project',
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: viewModel.technologiesController,
                    label: 'Technologies',
                    hint: 'Comma-separated: React, TypeScript, etc',
                    maxLines: 2,
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Project Status',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.heading,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => AppCheckbox(
                      value: viewModel.isFeatured,
                      onChanged: (_) => viewModel.toggleFeatured(),
                      label: 'Featured Project',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => AppCheckbox(
                      value: viewModel.isPrivate,
                      onChanged: (_) => viewModel.togglePrivate(),
                      label: 'Private Project (NDA)',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => AppCheckbox(
                      value: viewModel.isCurrentlyWorking,
                      onChanged: (_) => viewModel.toggleCurrentlyWorking(),
                      label: 'Currently Working On',
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Update Project',
                      onPressed: viewModel.updateProject,
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
