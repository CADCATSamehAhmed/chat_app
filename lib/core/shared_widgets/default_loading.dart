import 'package:chat_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> defaultLoading({
  Color? color,
  int? time,
  required Future<dynamic> asyncFunction,
}) async {
  return Get.showOverlay(
    asyncFunction: () async {
      await asyncFunction;
    },
    loadingWidget: Center(
      child: Container(
        padding:const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: CircularProgressIndicator(
          strokeWidth: 6,
          color: color ?? AppColors.mainColor,
        ),
      ),
    ), // Optional: custom loading widget
    opacityColor: Colors.black, // Optional: background color during loading
    opacity: 0.6, // Optional: background opacity
  );
}
