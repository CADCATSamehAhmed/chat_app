import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController defaultSnackBar({
  required String message,
}) {
  return Get.showSnackbar(
    GetSnackBar(
      message: message,
      backgroundColor: Colors.black.withOpacity(.5),
      barBlur: 1,
      duration: const Duration(seconds: 3),
      borderRadius: 25,
      margin: const EdgeInsets.all(50),
    ),
  );
}
