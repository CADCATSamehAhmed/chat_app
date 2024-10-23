import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final void Function() submit;

  const SaveButton({super.key,required this.submit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .09, vertical: screenHeight * .06),
      child: CustomButton(
        text: 'Save Profile',
        iconData: Icons.save,
        textColor: Colors.white,
        fontSize: 16,
        onPressed:submit,
        backgroundColor: AppColors.mainColor,
        shadowColor: Colors.grey,
        height: screenHeight * .07,
        width: screenWidth * .9,
      ),
    );
  }
}
