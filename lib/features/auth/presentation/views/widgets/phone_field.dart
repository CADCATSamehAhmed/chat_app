import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneField({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    RegExp phoneRegExp = RegExp(r'^01[0-9]{9}$');
    return  defaultFormField(
      controller: phoneController,
      type: TextInputType.phone,
      obscureText: false,
      label: 'your phone',
      validate: (String? phone) {
        if (phone!.isEmpty) {
          return 'phone number must not be empty';
        } else if (!phoneRegExp.hasMatch(phone)) {
          return 'the phone provided is not correct';
        } else{
          return null;
        }
      },
      prefixIcon: Icons.phone_android,
      suffixIcon: null,
      hint: 'enter your phone',
    );
  }
}
