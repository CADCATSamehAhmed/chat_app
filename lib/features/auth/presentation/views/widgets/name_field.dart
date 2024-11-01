import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController nameController;

  const NameField({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return DefaultDormField(
      controller: nameController,
      type: TextInputType.name,
      filledColor: Theme.of(context).primaryColorLight,
      obscureText: false,
      label: 'your name',
      validate: (String? name) {
        if (name!.isEmpty) {
          return 'name must not be empty';
        } else {
          return null;
        }
      },
      prefixIcon: Icons.person,
      suffixIcon: null,
      hint: 'enter your name',
    );
  }
}
