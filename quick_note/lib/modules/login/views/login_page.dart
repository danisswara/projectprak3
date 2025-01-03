import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_note/modules/forgot_password/forgot_password_page.dart';
import 'package:quick_note/modules/login/controllers/login_controller.dart';
import 'package:quick_note/modules/register/views/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Account',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3.0),
                const Text(
                  'Login with your email and password',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                Form(
                  key: loginController.formLogin,
                  child: Column(
                    children: [
                      // Username Field
                      TextFormField(
                        controller: loginController.usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username',
                          filled: true,
                          prefixIcon: Icon(Icons.person_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your username!';
                          }
                          if (value.length < 3) {
                            return 'Username must be at least 3 characters!';
                          }
                          return null;
                        },
                        maxLength: 20,
                      ),
                      const SizedBox(height: 16.0),
                      // Password Field
                      GetBuilder<LoginController>(
                        builder: (_) => TextFormField(
                          controller: loginController.passwordController,
                          obscureText: loginController.obscurePass,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            filled: true,
                            prefixIcon: const Icon(Icons.password_rounded),
                            suffixIcon: GestureDetector(
                              onTap: loginController.onObscurePass, // Panggil fungsi dari LoginController
                              child: Icon(loginController.obscurePass
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password!';
                            }
                            if (value.length < 4) {
                              return 'Password must be at least 4 characters!';
                            }
                            return null;
                          },
                          maxLength: 20,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Login Button with Loading Indicator
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: Obx(() => ElevatedButton(
                              onPressed: loginController.isLoading.value
                                  ? null
                                  : () {
                                      if (loginController
                                          .formLogin.currentState!
                                          .validate()) {
                                        loginController.loginAccount();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: loginController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Login'),
                            )),
                      ),
                      const SizedBox(height: 16.0),
                      // Forgot Password and Create Account Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => const ForgotPasswordPage());
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Color.fromARGB(255, 17, 19, 31)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const RegisterPage());
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
