import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/api_client/main_client.dart';
import 'package:portfolio/services/contact_service.dart';

class ContactViewModel extends GetxController {
  final ContactService _contactService = Get.find<ContactService>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final _isSubmitting = false.obs;

  bool get isSubmitting => _isSubmitting.value;

  Future<void> submitForm() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    _isSubmitting.value = true;
    update();
    try {
      await _contactService.submit(
        nameController.text.trim(),
        emailController.text.trim(),
        messageController.text.trim(),
      );
      nameController.clear();
      emailController.clear();
      messageController.clear();
      Get.snackbar(
        'Success',
        'Message sent successfully!',
        duration: const Duration(seconds: 3),
      );
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, duration: const Duration(seconds: 3));
    } catch (_) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        duration: const Duration(seconds: 3),
      );
    }
    _isSubmitting.value = false;
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
