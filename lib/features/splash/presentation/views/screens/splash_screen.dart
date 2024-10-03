import 'dart:async';
import 'package:chat_app/core/constants/images.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offNamed('login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(PngImages.splashLogo),height: screenWidth*.6,width: screenWidth*.6,),
          Text('WhatsUp',style: Fonts.font25.copyWith(color: AppColors.mainColor),),
          SizedBox(height: screenWidth*.4),
          Center(child: Text('The best chat app in this century',style: Fonts.font18,)),
        ],
      ),
    );
  }
}
