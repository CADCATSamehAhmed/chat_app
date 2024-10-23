import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final String text;
  const TextRow({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight*.03),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: Fonts.font14.copyWith(color: Colors.grey,fontWeight: FontWeight.bold),
      ),
    );
  }
}
