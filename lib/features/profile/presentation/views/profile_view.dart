import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/profile_body.dart';
import 'widgets/appbar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      appBar: profileAppBar(),
      body:const ProfileBody(),
    );
  }
}