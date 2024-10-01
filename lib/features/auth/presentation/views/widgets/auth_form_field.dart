import 'package:chat_app/core/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';

class AuthFormFiled extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?) validate;
  final void Function()? onTap;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String label;
  const AuthFormFiled({super.key, required this.context, required this.controller, required this.type, required this.validate, this.onTap, required this.label, required this.prefixIcon, required this.suffixIcon, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth*.05),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscureText,
        cursorColor: AppColors.mainColor,
        textAlign: TextAlign.start,
        validator: validate,
        onTap: onTap,
        style: Fonts.font18,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          helperText: label,
          helperStyle: Fonts.font18,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color:Colors.grey.withOpacity(.1),),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.mainColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
