import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final _isSubmitting = false.obs;
  final _submissionSuccess = false.obs;

  bool get isSubmitting => _isSubmitting.value;
  bool get submissionSuccess => _submissionSuccess.value;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      _isSubmitting.value = true;
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      _submissionSuccess.value = true;
      _isSubmitting.value = false;
      nameController.clear();
      emailController.clear();
      messageController.clear();
      Get.snackbar(
        'Success',
        'Message sent successfully!',
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

