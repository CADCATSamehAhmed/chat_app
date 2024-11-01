import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthFooter extends StatelessWidget {
  final String longText;
  final String shortText;
  final bool? navigateBack;

  const AuthFooter(
      {super.key,
      required this.longText,
      required this.shortText,
      this.navigateBack = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            longText,
            style: Fonts.font14.copyWith(color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(width: 10.w),
          TextButton(
            onPressed: () {
              if (navigateBack!) {
                Get.back();
              } else {
                Get.to(() => const SignUpView(),
                    transition: Transition.rightToLeft);
              }
            },
            child: Text(
              shortText,
              style: Fonts.font14.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
