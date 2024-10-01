import 'package:chat_app/core/constants/images.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/themes/styles.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(screenWidth*0.3,0,screenWidth*0.3,screenWidth*0.25),
          child: Image(image: AssetImage(PngImages.splashLogo),),
        ),
      ],
    );
  }
}
