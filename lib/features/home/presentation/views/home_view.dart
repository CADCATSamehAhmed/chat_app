import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/features/calls/presentation/views/calls_body.dart';
import 'package:chat_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:chat_app/features/home/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:chat_app/features/chat/presentation/views/chats_body.dart';
import 'package:chat_app/features/home/presentation/views/widgets/home_floating_action_button.dart';
import 'package:chat_app/features/profile/data/repo/profile_repo.dart';
import 'package:chat_app/features/status/presentation/views/statuses_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'widgets/home_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileRepo.getProfileData();
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackGroundColor,
            appBar: homeAppBar(context),
            body: homeScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavBar(
                currentIndex: cubit.currentIndex,
                onTap: (int index) {
                  cubit.changeBottomNavBarIndex(index);
                }),
            floatingActionButton:HomeFloatingActionButton(index: cubit.currentIndex),
          );
        });
  }
}

List<Widget> homeScreens = [
  const ChatsBody(),
  const StatusesBody(),
  const CallsBody(),
];
