import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_note/modules/register/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterController get registerControl => Get.find<RegisterController>();

  // Add key to the constructor if needed
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Account',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: registerControl.emailController.text.isNotEmpty
                            ? Colors.blue
                            : Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: registerControl.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Using Obx to reactively update UI
                  Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: registerControl.passController.text.isNotEmpty
                              ? Colors.blue
                              : Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: registerControl.passController,
                        obscureText: registerControl.obscurePass.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(registerControl.obscurePass.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => registerControl
                                .togglePasswordVisibility(isConfirmPass: false),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Dropdown button for selecting role
                  Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: registerControl.selectedRole.value.isNotEmpty
                              ? Colors.blue
                              : Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton<String>(
                        value: registerControl.selectedRole.value,
                        onChanged: (value) =>
                            registerControl.onChangeRole(value!),
                        items: const [
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text('Admin'),
                          ),
                          DropdownMenuItem(
                            value: 'user',
                            child: Text('User'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: registerControl.registerAccount,
                    child: const Text('Register Now'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
