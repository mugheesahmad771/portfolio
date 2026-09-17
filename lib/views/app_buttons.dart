import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isSmall;
  final Widget? icon;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.isSmall = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.isLoading;
    final hovering = _hovering && !disabled;

    return MouseRegion(
      cursor: disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: disabled ? null : widget.onPressed,
        child: AnimatedOpacity(
          opacity: disabled ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, hovering ? -2 : 0, 0),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isSmall ? 16 : 24,
              vertical: widget.isSmall ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: widget.isPrimary
                  ? (hovering ? AppColors.primaryHover : AppColors.primary)
                  : (hovering
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : Colors.transparent),
              border: Border.all(
                color: widget.isPrimary
                    ? Colors.transparent
                    : (hovering ? AppColors.primary : AppColors.border),
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: hovering
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.28),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : const [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: 8),
                ],
                if (widget.isLoading)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.isPrimary ? AppColors.bg : AppColors.primary,
                      ),
                    ),
                  )
                else
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.isSmall ? 12 : 14,
                      fontWeight: FontWeight.w600,
                      color: widget.isPrimary
                          ? AppColors.bg
                          : (hovering ? AppColors.primary : AppColors.title),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 48,
          height: 48,
          transform: Matrix4.translationValues(0, _hovering ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: _hovering
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            border: Border.all(
              color: _hovering ? AppColors.primary : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: _hovering
                ? (widget.color ?? AppColors.primary)
                : (widget.color ?? AppColors.muted),
          ),
        ),
      ),
    );
  }
}
