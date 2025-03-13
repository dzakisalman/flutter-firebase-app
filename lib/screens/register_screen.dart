import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void _register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama, email, dan password tidak boleh kosong.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(16),
      );
      return;
    }

    controller.updateLoading(true);
    await controller.registerWithEmailAndPassword(email, password, name);
    controller.updateLoading(false);
  }

  void _signInWithGoogle() async {
    controller.updateLoading(true);
    await controller.signInWithGoogle();
    controller.updateLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Buat Akun Baru',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Silakan lengkapi data diri Anda',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: 350,
                      borderRadius: 16,
                      blur: 8,
                      alignment: Alignment.center,
                      border: 1,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green.withOpacity(0.2),
                          Colors.blue.withOpacity(0.1),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green.withOpacity(0.5),
                          Colors.blue.withOpacity(0.2),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Nama Lengkap',
                                prefixIcon:
                                    Icon(Icons.person_outline, color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon:
                                    Icon(Icons.email_outlined, color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon:
                                    Icon(Icons.lock_outline, color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                            SizedBox(height: 24),
                            GetBuilder<AuthController>(
                              builder: (_) => ElevatedButton(
                                onPressed: controller.isLoading ? null : _register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.withOpacity(0.9),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: Size(double.infinity, 50),
                                  elevation: 0,
                                ),
                                child: controller.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        "Daftar",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Atau daftar dengan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 24),
                    GetBuilder<AuthController>(
                      builder: (_) => OutlinedButton(
                        onPressed: controller.isLoading ? null : _signInWithGoogle,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/google_logo.png', height: 24),
                            SizedBox(width: 12),
                            Text(
                              'Daftar dengan Google',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () => Get.offNamed('/login'),
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
