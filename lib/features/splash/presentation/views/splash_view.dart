import 'dart:async';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if(uid != null){
        Get.offNamed('home');
      }
      else{
        Get.offNamed('login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
