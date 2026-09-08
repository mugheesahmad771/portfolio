import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/pages/admin/viewmodel/admin_viewmodel.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _slugController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _roleController = TextEditingController();
  final _technologiesController = TextEditingController();

  bool _isFeatured = false;
  bool _isPrivate = false;
  bool _isCurrentlyWorking = false;

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    _roleController.dispose();
    _technologiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminViewModel>(
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            backgroundColor: AppColors.bgSecondary,
            elevation: 0,
            title: const Text(
              'Create Project',
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    label: 'Title',
                    controller: _titleController,
                    hint: 'Project title',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Slug',
                    controller: _slugController,
                    hint: 'project-slug',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Description',
                    controller: _descriptionController,
                    hint: 'Project description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Role',
                    controller: _roleController,
                    hint: 'Your role in this project',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Technologies',
                    controller: _technologiesController,
                    hint: 'Comma-separated: React, TypeScript, etc',
                    maxLines: 2,
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
                  _buildCheckbox(
                    label: 'Featured',
                    value: _isFeatured,
                    onChanged: (value) {
                      setState(() => _isFeatured = value ?? false);
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildCheckbox(
                    label: 'Private Project (NDA)',
                    value: _isPrivate,
                    onChanged: (value) {
                      setState(() => _isPrivate = value ?? false);
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildCheckbox(
                    label: 'Currently Working',
                    value: _isCurrentlyWorking,
                    onChanged: (value) {
                      setState(() => _isCurrentlyWorking = value ?? false);
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final technologies = _technologiesController.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList();

                          final project = ProjectModel(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            title: _titleController.text,
                            slug: _slugController.text,
                            shortDescription: _descriptionController.text,
                            fullDescription: _descriptionController.text,
                            role: _roleController.text,
                            technologies: technologies,
                            featured: _isFeatured,
                            privateProject: _isPrivate,
                            currentlyWorking: _isCurrentlyWorking,
                          );

                          viewModel.addProject(project);
                          Get.back();
                          Get.snackbar(
                            'Success',
                            'Project created successfully',
                            backgroundColor: AppColors.green,
                            colorText: AppColors.bg,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.bg,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Create Project',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
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
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.disabled),
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          style: const TextStyle(color: AppColors.title),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            side: const BorderSide(color: AppColors.border),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.title,
            ),
          ),
        ],
      ),
    );
  }
}
