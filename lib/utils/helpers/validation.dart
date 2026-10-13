import 'package:flutter/material.dart';

import '../constants/app_string.dart';

class AppValidation {
  AppValidation._();

  static final emailRegexp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  static final passRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$');

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppString.thisFieldIsRequired;
    }
    return null;
  }

  static String? email(String? value) {
    final error = required(value);
    if (error != null) return error;

    if (!emailRegexp.hasMatch(value!)) {
      return AppString.enterValidEmail;
    }
    return null;
  }

  static String? password(String? value) {
    final error = required(value);
    if (error != null) return error;
    if (value!.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain a special character';
    }
    return null;
  }

  static String? confirmPassword(
    String? value,
    TextEditingController passwordController,
  ) {
    final error = required(value);
    if (error != null) return error;

    if (value != passwordController.text) {
      return AppString.thePasswordDoesNotMatch;
    }
    return null;
  }
}
