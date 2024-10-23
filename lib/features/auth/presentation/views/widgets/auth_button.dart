import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/colors.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AuthButton({super.key,required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.mainColor,
      width: screenWidth*.9,
    );
  }
}
