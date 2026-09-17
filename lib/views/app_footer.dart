import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/app_route.dart';
import 'package:portfolio/core/constants/breakpoints.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  static const List<Map<String, String>> _navigateLinks = [
    {'label': 'About', 'route': AppRoute.about},
    {'label': 'Experience', 'route': AppRoute.experience},
    {'label': 'Projects', 'route': AppRoute.projects},
    {'label': 'Skills', 'route': AppRoute.skills},
    {'label': 'Resume', 'route': AppRoute.resume},
    {'label': 'Contact', 'route': AppRoute.contact},
  ];

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final isTablet = Breakpoints.isTablet(context);

    return Container(
      width: double.infinity,
      color: AppColors.bgSecondary,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : (isTablet ? 24 : 40),
        48,
        isMobile ? 16 : (isTablet ? 24 : 40),
        // Extra bottom clearance so the fixed scroll-to-top button (48px,
        // anchored 24px from the viewport bottom-right) never overlaps this
        // row's text once the page is scrolled all the way down.
        isMobile ? 48 : 88,
      ),
      child: Column(
        children: [
          if (isMobile)
            Column(
              children: [
                _buildBrandSection(),
                const SizedBox(height: 48),
                _buildLinksSection(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildBrandSection()),
                const SizedBox(width: 64),
                Expanded(flex: 1, child: _buildLinksSection()),
              ],
            ),
          const SizedBox(height: 32),
          const Divider(height: 1, color: AppColors.divider, thickness: 1),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} Mughees Ahmad. All rights reserved.',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: isMobile ? 11 : 12,
                ),
              ),
              if (!isMobile)
                const Text(
                  'Built with Flutter',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'MA',
                  style: TextStyle(
                    color: AppColors.bg,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Mughees Ahmad',
              style: TextStyle(
                color: AppColors.heading,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Full-stack developer crafting digital experiences',
          style: TextStyle(color: AppColors.muted, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _SocialIconButton(
              icon: Icons.code,
              onTap: () => _launchUrl('https://github.com/mugheesahmad771'),
            ),
            const SizedBox(width: 12),
            _SocialIconButton(
              icon: Icons.business_center,
              onTap: () => _launchUrl(
                'https://www.linkedin.com/in/mughees-ahmad-977105414/',
              ),
            ),
            const SizedBox(width: 12),
            _SocialIconButton(
              icon: Icons.mail_outline,
              onTap: () => _launchUrl('mailto:mugheesahmad771@gmail.com'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinksSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'NAVIGATE',
                style: TextStyle(
                  color: AppColors.disabled,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 16),
              ..._navigateLinks.map((link) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _FooterLink(
                    label: link['label']!,
                    onTap: () {
                      if (Get.currentRoute != link['route']) {
                        Get.toNamed(link['route']!);
                      }
                    },
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONTACT',
                style: TextStyle(
                  color: AppColors.disabled,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 16),
              _FooterLink(
                label: 'mugheesahmad771@gmail.com',
                onTap: () => _launchUrl('mailto:mugheesahmad771@gmail.com'),
              ),
              const SizedBox(height: 12),
              _FooterLink(
                label: '+92 318 6361580',
                onTap: () => _launchUrl('tel:+923186361580'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Multan, Pakistan',
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIconButton({required this.icon, required this.onTap});

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovering ? -2 : 0, 0),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hovering
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            border: Border.all(
              color: _hovering ? AppColors.primary : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 18,
              color: _hovering ? AppColors.primary : AppColors.muted,
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            color: _hovering ? AppColors.primary : AppColors.muted,
            fontSize: 13,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
