import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_color.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final bool showNavigation;
  final bool showFooter;
  final String? currentRoute;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.showNavigation = true,
    this.showFooter = true,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            child,
            if (showFooter)
              Container(
                margin: EdgeInsets.only(
                  top: isMobile ? 32 : 64,
                ),
                child: const SizedBox(),
              ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    final containerPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : (isTablet ? 24 : 32),
          vertical: isMobile ? 20 : 32,
        );

    final containerMaxWidth = maxWidth ?? (isMobile ? double.infinity : 1440);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: containerMaxWidth),
        child: Padding(
          padding: containerPadding,
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double spacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    final crossAxisCount = isMobile
        ? mobileColumns ?? 1
        : isTablet
            ? tabletColumns ?? 2
            : desktopColumns ?? 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
