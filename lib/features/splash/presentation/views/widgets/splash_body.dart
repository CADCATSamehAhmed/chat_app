import 'package:chat_app/core/constants/images.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BounceInDown(
          duration: const Duration(seconds: 2),
          from: 150,
          child: Center(
            child: Image(
              image: AssetImage(Images.logo),
              height: 215.w,
              width: 215.w,
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
          width: double.infinity,
        ),
        BounceInDown(
          duration: const Duration(seconds: 2),
          from: 150,
          child: Text(
            appName,
            textAlign: TextAlign.center,
            style: Fonts.font25.copyWith(fontSize: 30,color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
