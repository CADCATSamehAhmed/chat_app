import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFooter extends StatelessWidget {
  final String longText;
  final String shortText;
  final bool? navigateBack;

  const AuthFooter(
      {super.key,
      required this.longText,
      required this.shortText,
      this.navigateBack=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenWidth * .02),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            longText,
            style: Fonts.font14,
          ),
          TextButton(
            onPressed: () {
              if(navigateBack!){
                Get.back();
              }
              else{
                Get.to(()=>const SignUpScreen(),transition:Transition.rightToLeft);
              }
            },
            child: Text(
              shortText,
              style: Fonts.font14.copyWith(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
