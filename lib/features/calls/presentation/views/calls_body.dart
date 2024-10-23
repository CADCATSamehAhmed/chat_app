import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class CallsBody extends StatelessWidget {
  const CallsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*.05),
        child: Text(
          "To start calling contacts who have WhatsUp,tap call icon at the bottom of your screen",
          textAlign: TextAlign.center,
          style: Fonts.font18.copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}
