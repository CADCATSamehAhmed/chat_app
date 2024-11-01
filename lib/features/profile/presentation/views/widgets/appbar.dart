import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.h,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
      leading:IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColorDark,)),
      title: Text('Profile',style: Fonts.font25.copyWith(color: Theme.of(context).primaryColorDark),),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
