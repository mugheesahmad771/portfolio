import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/core/constants/breakpoints.dart';
import 'package:portfolio/pages/contact/viewmodel/contact_viewmodel.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/app_forms.dart';
import 'package:portfolio/views/app_section_header.dart';
import 'package:portfolio/views/responsive_layout.dart';
import 'package:portfolio/views/scroll_reveal.dart';
import 'package:portfolio/views/tilt_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return GetBuilder<ContactViewModel>(
      init: ContactViewModel(),
      builder: (viewModel) {
        return ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const SectionHeader(
                eyebrow: 'CONTACT',
                title: 'Get in Touch',
                description:
                    'Have a project idea or want to collaborate? I\'d love to hear from you.',
              ),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth < Breakpoints.mobile
                      ? 1
                      : (constraints.maxWidth < Breakpoints.desktop ? 2 : 3);
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: cols,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.6,
                    children: [
                      ScrollReveal(
                        id: 'contact-email',
                        child: _methodCard(
                          Icons.email_outlined,
                          'Email',
                          'mugheesahmad771@gmail.com',
                          () => launchUrl(
                            Uri.parse('mailto:mugheesahmad771@gmail.com'),
                          ),
                        ),
                      ),
                      ScrollReveal(
                        id: 'contact-phone',
                        child: _methodCard(
                          Icons.phone_outlined,
                          'Phone',
                          '+92 318 6361580',
                          () => launchUrl(Uri.parse('tel:+923186361580')),
                        ),
                      ),
                      ScrollReveal(
                        id: 'contact-location',
                        child: _methodCard(
                          Icons.location_on_outlined,
                          'Location',
                          'Multan, Pakistan',
                          null,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              ScrollReveal(
                id: 'contact-form',
                child: Form(
                  key: viewModel.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: viewModel.nameController,
                        label: 'Name',
                        hint: 'Your name',
                        isRequired: true,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        controller: viewModel.emailController,
                        label: 'Email',
                        hint: 'your@email.com',
                        isRequired: true,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        controller: viewModel.messageController,
                        label: 'Message',
                        hint: 'Your message...',
                        maxLines: 6,
                        isRequired: true,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: isMobile ? double.infinity : null,
                        child: AppButton(
                          label: 'Send Message',
                          onPressed: viewModel.submitForm,
                          isLoading: viewModel.isSubmitting,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _methodCard(
    IconData icon,
    String label,
    String value,
    VoidCallback? onTap,
  ) {
    final card = TiltCard(
      maxTilt: 0.06,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.disabled,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.title,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return onTap == null
        ? card
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(onTap: onTap, child: card),
          );
  }
}
