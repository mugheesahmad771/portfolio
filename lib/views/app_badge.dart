import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final bool showDot;
  final Color? backgroundColor;
  final Color? textColor;

  const AppBadge({
    super.key,
    required this.label,
    this.showDot = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (backgroundColor ?? AppColors.green).withValues(alpha: 0.15),
        border: Border.all(color: backgroundColor ?? AppColors.green),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: textColor ?? AppColors.green,
                borderRadius: BorderRadius.circular(3),
              ),
              margin: const EdgeInsets.only(right: 6),
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}
