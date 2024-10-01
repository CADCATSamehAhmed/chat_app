import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFooter extends StatelessWidget {
  final String longText;
  final String shortText;
  final String navigateTo;
  const AuthFooter({super.key, required this.longText, required this.shortText, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            longText,
            style: Fonts.font18,
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(navigateTo);
            },
            child: Text(
              shortText,
              style: Fonts.font18.copyWith(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
