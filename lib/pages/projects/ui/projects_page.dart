import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/projects/viewmodel/projects_viewmodel.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/pages/home/components/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return GetBuilder<ProjectsViewModel>(
      init: ProjectsViewModel(),
      builder: (viewModel) {
        return Container(
          color: AppColors.bg,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      eyebrow: 'PORTFOLIO',
                      title: 'All Projects',
                      description:
                          'Explore all projects I\'ve worked on, from mobile apps to full-stack applications.',
                    ),
                    const SizedBox(height: 32),
                    _buildFilterSection(viewModel, isMobile),
                    const SizedBox(height: 32),
                    _buildProjectsGrid(viewModel, isMobile),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(ProjectsViewModel viewModel, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) => viewModel.search(value),
          decoration: InputDecoration(
            hintText: 'Search projects...',
            hintStyle: const TextStyle(color: AppColors.disabled),
            filled: true,
            fillColor: AppColors.card,
            prefixIcon: const Icon(Icons.search, color: AppColors.muted),
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
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          style: const TextStyle(color: AppColors.title),
        ),
        const SizedBox(height: 24),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: viewModel.categories
                .map((category) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () => viewModel.setCategory(category),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: viewModel.selectedCategory == category
                                  ? AppColors.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    viewModel.selectedCategory == category
                                        ? AppColors.primary
                                        : AppColors.border,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: viewModel.selectedCategory == category
                                    ? AppColors.bg
                                    : AppColors.title,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(ProjectsViewModel viewModel, bool isMobile) {
    return Obx(
      () => viewModel.filteredProjects.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 64,
                      color: AppColors.disabled,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No projects found',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: viewModel.filteredProjects.length,
              itemBuilder: (context, index) {
                final project = viewModel.filteredProjects[index];
                return ProjectCard(
                  project: project,
                  onTap: () => Get.toNamed('/projects/${project.slug}'),
                );
              },
            ),
    );
  }
}
