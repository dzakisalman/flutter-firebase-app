import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> launchURL(String url, {bool inApp = true}) async {
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

  static Future<void> makePhoneCall(String phoneNumber) async {
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

  static Future<void> sendSMS(String phoneNumber) async {
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

  static Future<void> sendEmail(String email) async {
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

  static Future<void> shareText() async {
    try {
      await Share.share(
        'Halo! Ini adalah pesan yang dibagikan dari aplikasi Flutter saya.',
        subject: 'Berbagi Teks',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat membagikan teks: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future<void> shareLink() async {
    try {
      await Share.share(
        'https://flutter.dev',
        subject: 'Website Flutter',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat membagikan tautan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future<void> shareImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final bool? shouldShare = await Get.dialog<bool>(
          Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Bagikan Gambar Ini?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 300,
                  ),
                  child: Image.file(
                    File(image.path),
                    fit: BoxFit.contain,
                  ),
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () => Get.back(result: false),
                      child: Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      child: Text('Bagikan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

        if (shouldShare == true) {
          await Share.shareXFiles(
            [image],
            text: 'Gambar dibagikan dari aplikasi Flutter',
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat membagikan gambar: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  static Future<void> openPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);

        Get.to(() => Scaffold(
              appBar: AppBar(
                title: Text(result.files.single.name),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
              body: const PDF().fromPath(
                file.path,
              ),
            ));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat membuka file PDF: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
