import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/default_icon_button.dart';
import 'package:chat_app/core/shared_widgets/default_loading.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:chat_app/features/home/presentation/views/widgets/search_body.dart';
import 'package:chat_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as get_x;

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 70.h,
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
      title: Text(
        appName,
        style: Fonts.font25.copyWith(color: Theme.of(context).primaryColor),
      ),
      leadingWidth: 1.w,
      actions: [
        DefaultIconButton(
            iconData: Icons.search,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearch());
            }),
        SizedBox(width: 10.w),
        BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return PopupMenuButton<String>(
                key: menuKey,
                color: Theme.of(context).scaffoldBackgroundColor,
                onSelected: (String value) {
                  if (value == 'dark_light') {
                    HomeCubit.get(context).changeAppMode();
                  } else if (value == 'Profile') {
                    get_x.Get.to(() => const ProfileView(),
                        transition: get_x.Transition.rightToLeft);
                  } else if (value == 'Logout') {
                    defaultLoading(
                      context: context,
                        asyncFunction: HomeCubit.get(context).logOut());
                  }
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuEntry<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Fonts.font14.copyWith(color: Theme.of(context).primaryColorDark),
                      ),
                    );
                  }).toList();
                },
                child: DefaultIconButton(
                    iconData: Icons.more_vert,
                    onPressed: () {
                      final dynamic state = menuKey.currentState;
                      state.showButtonMenu();
                    }),
              );
            }),
        SizedBox(width: 10.w),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
final List<String> items = ['dark_light', 'Profile', 'Logout'];
