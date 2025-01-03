import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_note/modules/home/views/home_page.dart';
import 'package:quick_note/services/login_service.dart';

class LoginController extends GetxController {
  final formLogin = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs; // Properti reaktif untuk melacak status loading
  bool obscurePass = true;

  // Fungsi untuk toggle visibility password
  void onObscurePass() {
    obscurePass = !obscurePass;
    update();
  }

  // Fungsi untuk proses login
  Future<void> loginAccount() async {
    if (!(formLogin.currentState?.validate() ?? false)) {
      return; // Jika form tidak valid, keluar dari fungsi
    }

    isLoading.value = true; // Mulai loading
    try {
      // Memanggil service login
      final result = await LoginService.fetchLoginAccount(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result['success'] == true) {
        // Login berhasil
        Get.snackbar('Success', 'Login berhasil');
        Get.off(() => const HomePage(), arguments: {
          'id': result['id'],
          'email': result['email'],
          'username': result['username'],
          'role': result['role'],
        });
      } else {
        // Login gagal dengan pesan error dari server
        Get.snackbar('Error', 'Login gagal: ${result['message']}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Tangani kesalahan yang tidak terduga
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }
}
