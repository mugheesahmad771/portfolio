import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/pages/projects/viewmodel/projects_viewmodel.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_project_card.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/empty_state.dart';
import 'package:portfolio/views/scroll_reveal.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return GetBuilder<ProjectsViewModel>(
      init: ProjectsViewModel(),
      builder: (viewModel) {
        return Container(
          color: AppColors.bg,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 40,
              vertical: 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  eyebrow: 'PORTFOLIO',
                  title: 'All Projects',
                  description:
                      'Explore all projects I\'ve worked on, from mobile apps to full-stack applications.',
                ),
                const SizedBox(height: 32),
                _buildFilterSection(viewModel, isMobile),
                const SizedBox(height: 32),
                _buildBody(viewModel, isMobile),
                const SizedBox(height: 48),
              ],
            ),
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
        Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: viewModel.categories
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
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
                              color: viewModel.selectedCategory == category
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
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ProjectsViewModel viewModel, bool isMobile) {
    return Obx(() {
      if (viewModel.isLoading) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 64),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        );
      }
      if (viewModel.hasError) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.disabled,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Couldn\'t load projects.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                AppButton(label: 'Retry', onPressed: viewModel.loadProjects),
              ],
            ),
          ),
        );
      }
      if (viewModel.filteredProjects.isEmpty) {
        return const EmptyState(
          icon: Icons.folder_open_outlined,
          message: 'No projects found',
        );
      }
      return LayoutBuilder(
        builder: (context, constraints) {
          final cols = isMobile ? 1 : 2;
          // Fixed-aspect-ratio GridView forces every card to the same
          // height regardless of its title/description/chip content — a
          // Wrap of fixed-width cards lets each one size to its own
          // content instead (same fix as skills_page.dart).
          const spacing = 16.0;
          final cardWidth =
              (constraints.maxWidth - spacing * (cols - 1)) / cols;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: viewModel.filteredProjects
                .map(
                  (project) => SizedBox(
                    width: cardWidth,
                    child: ScrollReveal(
                      id: 'project-${project.id}',
                      child: ProjectCard(project: project),
                    ),
                  ),
                )
                .toList(),
          );
        },
      );
    });
  }
}
