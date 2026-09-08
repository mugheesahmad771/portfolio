import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/project_detail/viewmodel/project_detail_viewmodel.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/pages/home/components/tech_chip.dart';
import 'package:portfolio/views/app_header.dart';
import 'package:portfolio/views/app_navigation_bar.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/responsive_layout.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return GetBuilder<ProjectDetailViewModel>(
      init: ProjectDetailViewModel(),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppHeader(currentRoute: '/projects'),
                AppNavigationBar(currentRoute: '/projects'),
                ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back,
                                color: AppColors.primary),
                            const SizedBox(width: 8),
                            const Text(
                              'Back to Projects',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Project Image Placeholder
                      Container(
                        width: double.infinity,
                        height: isMobile ? 250 : 400,
                        decoration: BoxDecoration(
                          color: AppColors.elevated,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            size: isMobile ? 48 : 64,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        viewModel.project.title,
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.heading,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        viewModel.project.shortDescription.isNotEmpty 
                          ? viewModel.project.shortDescription 
                          : viewModel.project.fullDescription,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.muted,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          if (viewModel.project.featured)
                            _buildBadge('Featured', AppColors.orange),
                          const SizedBox(width: 8),
                          if (viewModel.project.privateProject)
                            _buildBadge('NDA', AppColors.purple),
                          const SizedBox(width: 8),
                          if (viewModel.project.currentlyWorking)
                            _buildBadge('Ongoing', AppColors.green),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SectionHeader(
                        eyebrow: 'DETAILS',
                        title: 'About This Project',
                      ),
                      const SizedBox(height: 24),
                      _buildDetailRow('Role', viewModel.project.role),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Technologies Used',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.heading,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: viewModel.project.technologies
                                .map((tech) =>
                                    TechChip(label: tech, isSmall: false))
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
                AppFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.body,
            ),
          ),
        ),
      ],
    );
  }
}
