import 'package:chat_app/features/calls/presentation/views/calls_body.dart';
import 'package:chat_app/features/chat/presentation/views/groups_body.dart';
import 'package:chat_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:chat_app/features/home/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:chat_app/features/chat/presentation/views/chats_body.dart';
import 'package:chat_app/features/home/presentation/views/widgets/home_floating_action_button.dart';
import 'package:chat_app/features/status/presentation/views/statuses_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'widgets/home_appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).onUserLogin(context);
  }
  @override
  void dispose() {
    HomeCubit.get(context).onUserLogout();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const HomeAppBar(),
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
  const GroupsBody(),
  const StatusesBody(),
  const CallsBody(),
];
