import 'package:chat_app/core/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';

class AuthButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final BuildContext context;
  const AuthButton({super.key, required this.context,required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: screenWidth*.9,
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 9),
          decoration: BoxDecoration(
            color:AppColors.mainColor,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Center(
            child: Text(
              text,
              style: Fonts.font25,
            ),
          ),
        ),
      );
  }
}
