import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_note/modules/home/views/home_page.dart';
import 'package:quick_note/modules/login/bindings/login_bindings.dart';
import 'package:quick_note/modules/login/views/login_page.dart';
import 'package:quick_note/modules/register/bindings/register_bindings.dart';
import 'package:quick_note/modules/register/controllers/register_controller.dart';
import 'package:quick_note/modules/register/views/register_page.dart';

void main() {
  // Inisialisasi controller atau dependency global
  Get.put(RegisterController()); // RegisterController global

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quick Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Rute pertama yang dijalankan
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          binding: LoginBindings(), // Menggunakan LoginBindings
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterPage(),
          binding: RegisterBindings(), // Menggunakan RegisterBindings
        ),
      ],
    );
  }
}
