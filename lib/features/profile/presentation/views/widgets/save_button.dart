import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final void Function() submit;

  const SaveButton({super.key,required this.submit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
      child: CustomButton(
        text: 'Save Profile',
        iconData: Icons.save,
        textColor: Colors.white,
        fontSize: 16.sp,
        onPressed:submit,
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.grey,
        height: 50.h,
        width: 300.w,
      ),
    );
  }
}
