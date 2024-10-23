import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget profileAppBar(){
  return AppBar(
    toolbarHeight: screenHeight*.11,
    backgroundColor: AppColors.appBarBackGroundColor,
    shape: const Border(bottom: BorderSide(color: Colors.grey)),
    leading:IconButton(onPressed: (){
      Get.back();
    }, icon: Icon(Icons.arrow_back,color: AppColors.mainColor,)),
    title: Text('Profile',style: Fonts.font25,),
  );
}