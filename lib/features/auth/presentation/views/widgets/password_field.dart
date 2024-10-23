import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final VoidCallback toggleVisibility;
  final bool isPasswordVisible;

  const PasswordField(
      {super.key,
      required this.passwordController,
      required this.toggleVisibility,
      required this.isPasswordVisible});

  @override
  Widget build(BuildContext context) {
    return defaultFormField(
      controller: passwordController,
      type: TextInputType.text,
      obscureText: isPasswordVisible,
      label: 'your password',
      validate: (String? password) {
        if (password!.isEmpty) {
          return 'password is too short';
        } else if (password.length < 4) {
          return 'the password provided is too week';
        } else {
          return null;
        }
      },
      prefixIcon: Icons.lock,
      suffixIcon:isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      suffixPressed: toggleVisibility,
      hint: 'enter your password',
    );
  }
}
