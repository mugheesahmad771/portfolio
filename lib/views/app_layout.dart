import 'package:flutter/material.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/header.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Header(),
          child,
          const AppFooter(),
        ],
      ),
    );
  }
}
