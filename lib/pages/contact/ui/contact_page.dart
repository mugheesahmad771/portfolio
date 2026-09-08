import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/constants/app_color.dart';
import 'package:portfolio/pages/contact/viewmodel/contact_viewmodel.dart';
import 'package:portfolio/pages/home/components/section_header.dart';
import 'package:portfolio/views/app_header.dart';
import 'package:portfolio/views/app_navigation_bar.dart';
import 'package:portfolio/views/app_footer.dart';
import 'package:portfolio/views/app_forms.dart';
import 'package:portfolio/views/app_buttons.dart';
import 'package:portfolio/views/responsive_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return GetBuilder<ContactViewModel>(
      init: ContactViewModel(),
      builder: (viewModel) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppHeader(currentRoute: '/contact'),
                AppNavigationBar(currentRoute: '/contact'),
                ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      SectionHeader(
                        eyebrow: 'CONTACT',
                        title: 'Get in Touch',
                        description:
                            'Have a project idea or want to collaborate? I\'d love to hear from you.',
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: viewModel.formKey,
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
                                if (!RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+$')
                                    .hasMatch(value!)) {
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
                              width: isMobile
                                  ? double.infinity
                                  : null,
                              child: AppButton(
                                label: 'Send Message',
                                onPressed: viewModel.submitForm,
                                isLoading: viewModel.isSubmitting,
                              ),
                            ),
                          ],
                        ),
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
}
