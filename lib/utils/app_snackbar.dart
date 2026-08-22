import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success({required String title, required String message}) {
    _showSnackbar(
      title: title.isNotEmpty ? title : 'Success',
      message: message,
      backgroundColor: const Color(0xFF052E16),
      textColor: const Color(0xFF22C55E),
      position: SnackPosition.BOTTOM,
    );
  }

  static void error({String? title, required String message}) {
    _showSnackbar(
      title: (title != null && title.isNotEmpty) ? title : 'Error',
      message: message,
      backgroundColor: const Color(0xFF450A0A),
      textColor: const Color(0xFFEF4444),
      position: SnackPosition.TOP,
    );
  }

  static void _showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required SnackPosition position,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: textColor,
      backgroundColor: backgroundColor,
      snackPosition: position,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}
