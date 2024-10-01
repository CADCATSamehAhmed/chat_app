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
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 9),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color:AppColors.mainColor)],
              gradient: LinearGradient(
                  colors: [AppColors.mainColor]
              ),
              borderRadius: BorderRadius.circular(18)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Fonts.font18,
              ),
            ],
          ),
        ),
      );
  }
}
