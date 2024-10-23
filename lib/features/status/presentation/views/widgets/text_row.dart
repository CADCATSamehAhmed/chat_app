import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class StatusTextRow extends StatelessWidget {
  final String text;
  const StatusTextRow({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight*.02,horizontal: screenWidth*.02),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Fonts.font14.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),
      ),
    );
  }
}
