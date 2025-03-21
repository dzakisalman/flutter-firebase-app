import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/auth_controller.dart';
import '../utils/utils.dart';
import '../widgets/custom_buttons.dart';

class HomeScreen extends GetView<AuthController> {
  const HomeScreen({super.key});

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
            CustomButtons.buildLauncherButton(
              icon: Icons.qr_code_scanner,
              label: "Pindai QR/Barcode",
              color: Colors.deepOrange,
              onPressed: () => Get.to(() => QRScannerScreen()),
            ),
            SizedBox(height: 12),
            CustomButtons.buildLauncherButton(
              icon: Icons.open_in_browser,
              label: "Buka URL di Aplikasi",
              color: Colors.blue,
              onPressed: () =>
                  Utils.launchURL('https://flutter.dev', inApp: true),
            ),
            SizedBox(height: 12),
            CustomButtons.buildLauncherButton(
              icon: Icons.launch,
              label: "Buka URL di Browser",
              color: Colors.green,
              onPressed: () => Utils.launchURL('https://pub.dev', inApp: false),
            ),
            SizedBox(height: 12),
            CustomButtons.buildLauncherButton(
              icon: Icons.phone,
              label: "Panggil Nomor",
              color: Colors.orange,
              onPressed: () => Utils.makePhoneCall('+6281234567890'),
            ),
            SizedBox(height: 12),
            CustomButtons.buildLauncherButton(
              icon: Icons.message,
              label: "Kirim SMS",
              color: Colors.purple,
              onPressed: () => Utils.sendSMS('+6281234567890'),
            ),
            SizedBox(height: 12),
            CustomButtons.buildLauncherButton(
              icon: Icons.email,
              label: "Kirim Email",
              color: Colors.red,
              onPressed: () => Utils.sendEmail('example@gmail.com'),
            ),
            SizedBox(height: 12),
            CustomButtons.buildLauncherButton(
              icon: Icons.picture_as_pdf,
              label: "Buka File PDF",
              color: Colors.brown,
              onPressed: Utils.openPDF,
            ),
            SizedBox(height: 24),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButtons.buildShareButton(
                      icon: Icons.text_fields,
                      label: "Berbagi\nTeks",
                      color: Colors.teal,
                      onPressed: Utils.shareText,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CustomButtons.buildShareButton(
                      icon: Icons.link,
                      label: "Berbagi\nLink",
                      color: Colors.indigo,
                      onPressed: Utils.shareLink,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CustomButtons.buildShareButton(
                      icon: Icons.image,
                      label: "Berbagi\nGambar",
                      color: Colors.deepPurple,
                      onPressed: Utils.shareImage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR/Barcode Scanner'),
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              Get.snackbar(
                'Hasil Pemindaian',
                'Konten: ${barcode.rawValue}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
              );
            }
          }
        },
      ),
    );
  }
}
