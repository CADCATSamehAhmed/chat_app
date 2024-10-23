import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(r'^\w+@gmail\.com$');
    return defaultFormField(
      controller: emailController,
      type: TextInputType.emailAddress,
      obscureText: false,
      label: 'your email',
      validate: (String? email) {
        if (email!.isEmpty) {
          return 'email must not be empty';
        } else if (!regex.hasMatch(email)) {
          return 'email must end with @gmail.com';
        } else{
          return null;
        }
      },
      prefixIcon: Icons.email,
      suffixIcon: null,
      hint: 'enter your email',
    );
  }
}
