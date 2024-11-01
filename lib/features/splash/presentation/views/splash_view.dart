import 'dart:async';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/cache_helper.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/onboarding_body.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/splash_body.dart';
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
      if(CacheHelper.getData(key: 'isFirstTime') == null){
        Get.off(()=>const OnboardingBody(),transition: Transition.fadeIn);
      } else if (uid != null){
        Get.off(()=>const HomeView(),transition: Transition.fadeIn);
      } else{
        Get.off(()=>const LoginView(),transition: Transition.fadeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SplashBody(),
    );
  }
}
