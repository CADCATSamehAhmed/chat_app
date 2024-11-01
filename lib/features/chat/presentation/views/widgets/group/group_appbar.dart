import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/shared_widgets/default_icon_button.dart';
import 'package:chat_app/core/shared_widgets/default_loading.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/group_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/call_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GroupModel group;
  const GroupAppBar({
    super.key, required this.group,
  });
  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();
    ThemeData theme =Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarHeight: 70.h,
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
      leading: Row(
        children: [
          BlocConsumer<ChatCubit, ChatStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return DefaultIconButton(
                    iconData: Icons.arrow_back,
                    borderRadius: 20.sp,
                    onPressed: () {
                      ChatCubit.get(context).closeChat(true,group.groupId);
                      Get.back();
                    },
                );
              }),
          SizedBox(width: 4.w),
          CircleAvatar(
            radius: 20,
            foregroundImage: CachedNetworkImageProvider(group.groupImage),
          ),
          SizedBox(width: 4.w),
          Text(
            group.groupName,
            style: Fonts.font18.copyWith(color: theme.primaryColorDark),
          ),
        ],
      ),
      leadingWidth: 245.w,
      actions: [
        CallInvitationButton(
            partnerIds: group.groupPartnerIds,
            partnerNames: group.groupPartnerIds,
            isVideo: true),
        CallInvitationButton(
            partnerIds: group.groupPartnerIds,
            partnerNames: group.groupPartnerIds,
            isVideo: false),
        BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return PopupMenuButton<String>(
                color: theme.scaffoldBackgroundColor,
                key: menuKey,
                onSelected: (String value) async{
                  if (value == 'Delete Chat') {
                    // await defaultLoading(asyncFunction: ChatCubit.get(context).deleteChat(chat), context: context);
                    // Get.back();
                  }else{
                    await defaultLoading(asyncFunction: ChatCubit.get(context).clearChat(group.groupId), context: context);
                    Get.back();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuEntry<String>>((String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Fonts.font14.copyWith(color: theme.primaryColorDark),
                      ),
                    );
                  }).toList();
                },
                child: DefaultIconButton(
                    iconData: Icons.more_vert,
                    onPressed: () {
                      final dynamic state = menuKey.currentState;
                      state.showButtonMenu();
                    },
                ),
              );
            }),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(70.h);
}

final List<String> items = [
  'Delete Chat',
  'Clear Chat',
];
