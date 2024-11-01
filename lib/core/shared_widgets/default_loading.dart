import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> defaultLoading({
  Color? color,
  required BuildContext context,
  required Future<dynamic> asyncFunction,
}) async {
  return Get.showOverlay(
    asyncFunction: () async {
      await asyncFunction;
    },
    loadingWidget: Center(
      child: Container(
        padding:const EdgeInsets.all(20).w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15).r,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: CircularProgressIndicator(
          strokeWidth: 6.w,
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    ), // Optional: custom loading widget
    opacityColor: Colors.black, // Optional: background color during loading
    opacity: 0.6, // Optional: background opacity
  );
}
