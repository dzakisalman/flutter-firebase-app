import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../gen/assets.gen.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginWithEmail() async {
    controller.updateLoading(true);
    await controller.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    controller.updateLoading(false);
  }

  void loginWithGoogle() async {
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
                    SizedBox(height: 20),
                    Center(
                      child: Lottie.asset(
                        Assets.animations.logo,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Silakan masuk ke akun Anda',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: 250,
                      borderRadius: 16,
                      blur: 15,
                      alignment: Alignment.center,
                      border: 2,
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon:
                                    Icon(Icons.email_outlined, color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.8),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
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
                                fillColor: Colors.white.withOpacity(0.8),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                            SizedBox(height: 24),
                            GetBuilder<AuthController>(
                              builder: (_) => ElevatedButton(
                                onPressed:
                                    controller.isLoading ? null : loginWithEmail,
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
                                        "Masuk",
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
                        Expanded(child: Divider(color: Colors.white54)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Atau masuk dengan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white54)),
                      ],
                    ),
                    SizedBox(height: 24),
                    GetBuilder<AuthController>(
                      builder: (_) => OutlinedButton(
                        onPressed: controller.isLoading ? null : loginWithGoogle,
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
                              'Masuk dengan Google',
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
                          'Belum punya akun? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed('/register'),
                          child: Text(
                            'Daftar',
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
