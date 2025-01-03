import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formRegister = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  final obscurePass = true.obs;
  final selectedRole = 'admin'.obs;

  void togglePasswordVisibility({required bool isConfirmPass}) {
    if (isConfirmPass) {
      obscurePass.value = !obscurePass.value;
    }
  }

  void onChangeRole(String value) {
    selectedRole.value = value;
  }

  Future<void> registerAccount() async {
    if (formRegister.currentState?.validate() ?? false) {
      // Registrasi berhasil
      Get.offAllNamed('/login');
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
    
  }
}
