import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusTextRow extends StatelessWidget {
  final String text;
  const StatusTextRow({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Fonts.font14.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),
      ),
    );
  }
}
