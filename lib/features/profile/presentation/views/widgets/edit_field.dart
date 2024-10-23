import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class EditField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const EditField({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * .05, vertical: screenHeight * .01),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey,
            blurRadius: 30,
            spreadRadius: 0.5,
            offset: Offset(0, 15)),
      ]),
      child: defaultFormField(
        controller: controller,
        type: TextInputType.name,
        obscureText: false,
        hint: 'edit your $text',
        filledColor: Colors.white,
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
