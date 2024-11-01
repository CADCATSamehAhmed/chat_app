import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final double? borderRadius;

  const DefaultIconButton({
    super.key,
    required this.iconData,
    this.borderRadius,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10).w,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(borderRadius?.r??10.r)
        ),
        child: Icon(
          iconData,color:Theme.of(context).primaryColor,size: 20.sp,
        ),
      ),
    );
  }
}
