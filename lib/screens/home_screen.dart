import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends GetView<AuthController> {
  Future<void> _launchURL(String url, {bool inApp = true}) async {
    try {
      final uri = Uri.parse(url);
      if (inApp) {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } else {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat membuka URL: $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final uri = Uri.parse('tel:$phoneNumber');
      await launchUrl(uri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat melakukan panggilan ke: $phoneNumber',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _sendSMS(String phoneNumber) async {
    try {
      final uri = Uri.parse('sms:$phoneNumber');
      await launchUrl(uri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat mengirim SMS ke: $phoneNumber',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _sendEmail(String email) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': 'Hello from Flutter App',
          'body': 'Hi, this is a message from our Flutter application.',
        },
      );
      await launchUrl(emailLaunchUri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat mengirim email ke: $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await controller.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetBuilder<AuthController>(
                builder: (_) => Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Selamat datang,",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          controller.userName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          controller.user?.email ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildLauncherButton(
                icon: Icons.open_in_browser,
                label: "Buka URL di Aplikasi",
                color: Colors.blue,
                onPressed: () => _launchURL('https://flutter.dev', inApp: true),
              ),
              SizedBox(height: 12),
              _buildLauncherButton(
                icon: Icons.launch,
                label: "Buka URL di Browser",
                color: Colors.green,
                onPressed: () => _launchURL('https://pub.dev', inApp: false),
              ),
              SizedBox(height: 12),
              _buildLauncherButton(
                icon: Icons.phone,
                label: "Panggil Nomor",
                color: Colors.orange,
                onPressed: () => _makePhoneCall('+6281234567890'),
              ),
              SizedBox(height: 12),
              _buildLauncherButton(
                icon: Icons.message,
                label: "Kirim SMS",
                color: Colors.purple,
                onPressed: () => _sendSMS('+6281234567890'),
              ),
              SizedBox(height: 12),
              _buildLauncherButton(
                icon: Icons.email,
                label: "Kirim Email",
                color: Colors.red,
                onPressed: () => _sendEmail('example@gmail.com'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLauncherButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
