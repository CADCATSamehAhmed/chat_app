import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyRow extends StatelessWidget {
  const ReplyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 10,
      right: 10,
      child: GestureDetector(
        onTap: () {
          Get.showSnackbar(const GetSnackBar(
            title: 'Status',
            message: 'Replied successful',
            backgroundColor: Colors.transparent,
            borderRadius: 9,
            duration: Duration(seconds: 2),
          ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reply",
              style: Fonts.font14
                  .copyWith(color: Colors.grey, decoration: TextDecoration.none),
            ),
            Icon(
              Icons.arrow_upward,
              color: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }
}
