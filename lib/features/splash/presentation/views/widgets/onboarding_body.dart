import 'package:chat_app/core/constants/images.dart';
import 'package:chat_app/core/shared_prefences/cache_helper.dart';
import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: AssetImage(Images.chatting),
              height: 260.w,
              width: 250.w,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(height: 20.h),
            Text(
              'Connect easily with your family and friends over countries',
              textAlign: TextAlign.center,
              style: Fonts.font20.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 150.h),
            CustomButton(
              text: 'Start Messaging',
              textColor: Colors.white,
              fontSize: 16.sp,
              onPressed: () {
                CacheHelper.putBoolean(key: 'isFirstTime', value: false);
                Get.off(() => const LoginView(), transition: Transition.fadeIn);
              },
              backgroundColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50).r,
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
