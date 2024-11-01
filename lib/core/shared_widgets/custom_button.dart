import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? shadowColor;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool loading;

  const CustomButton({
    super.key,
    required this.text,
    this.iconData,
    this.backgroundColor,
    this.shadowColor,
    this.borderRadius,
    this.fontSize,
    this.textColor,
    required this.onPressed,
    this.height = 45,
    this.width,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(25.r))),
        child: loading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconData != null) Icon(iconData, color: Colors.white),
                  if (iconData != null) SizedBox(width: 10.w),
                  Text(
                    text,
                    style: Fonts.font20.copyWith(
                      color: textColor ?? Colors.black,
                      fontSize: fontSize ?? 25.sp,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
