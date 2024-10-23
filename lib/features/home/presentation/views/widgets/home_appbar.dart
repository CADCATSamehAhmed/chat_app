import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/start_new_group_body.dart';
import 'package:chat_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:chat_app/features/home/presentation/views/widgets/search_body.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_x;

PreferredSizeWidget homeAppBar(BuildContext context) {
  final GlobalKey menuKey = GlobalKey();
  return AppBar(
    toolbarHeight: screenHeight * .11,
    backgroundColor: AppColors.appBarBackGroundColor,
    shape: const Border(bottom: BorderSide(color: Colors.grey)),
    leading: const SizedBox(width: 10),
    title: Text(
      'WhatsUp',
      style: Fonts.font25,
    ),
    actions: [
      IconButton(
          onPressed: () {
            showSearch(context: context, delegate: CustomSearch());
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          )),
      BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return PopupMenuButton<String>(
              key: menuKey,
              onSelected: (String value) {
                if (value == 'New Group') {
                  ChatCubit.get(context).getUsers();
                  get_x.Get.to(()=>const StartNewGroupBody(),transition: get_x.Transition.rightToLeft);
                }else if (value == 'Profile') {
                  ProfileCubit.get(context).getUserData();
                  get_x.Get.toNamed('profile');
                } else if (value == 'Logout') {
                  HomeCubit.get(context).logOut();
                }
              },
              color: AppColors.appBarBackGroundColor,
              itemBuilder: (BuildContext context) {
                return items.map<PopupMenuEntry<String>>((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Fonts.font14,
                    ),
                  );
                }).toList();
              },
              child: IconButton(
                onPressed: () {
                  final dynamic state = menuKey.currentState;
                  state.showButtonMenu();
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            );
          }),
    ],
  );
}

final List<String> items = ['New Group', 'Profile', 'Logout'];
