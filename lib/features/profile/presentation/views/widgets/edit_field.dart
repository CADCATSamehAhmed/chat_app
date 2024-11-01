import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String hint;

  const EditField({
    super.key,
    required this.controller,
    required this.text,
    this.hint = 'edit your',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Theme.of(context).canvasColor,
            blurRadius: 30.sp,
            spreadRadius: 0.5,
            offset: const Offset(0, 15)),
      ]),
      child: DefaultDormField(
        controller: controller,
        type: TextInputType.name,
        obscureText: false,
        hint: '$hint $text',
        filledColor: Theme.of(context).primaryColorLight,
        // onEditingComplete: onEditingComplete,
        validate: (String? s) {
          if (s!.isEmpty) {
            return '$text can not be empty';
          } else {
            return null;
          }
        },
        prefixIcon: null,
        suffixIcon: null,
        label: null,
      ),
    );
  }
}
