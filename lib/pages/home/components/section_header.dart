import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? description;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.disabled,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 12),
          Text(
            description!,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.muted,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}
