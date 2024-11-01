import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/shared_widgets/default_icon_button.dart';
import 'package:chat_app/core/shared_widgets/default_loading.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/call_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatModel chat;
  const ChatAppBar({
    super.key, required this.chat,
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
                    ChatCubit.get(context).closeChat(false, chat.chatId);
                    Get.back();
                  },
                );
              }),
          SizedBox(width: 4.w),
          CircleAvatar(
            radius: 20,
            foregroundImage: CachedNetworkImageProvider(chat.image),
          ),
          SizedBox(width: 4.w),
          Text(
            chat.name,
            style: Fonts.font18.copyWith(color: theme.primaryColorDark),
          ),
        ],
      ),
      leadingWidth: 245.w,
      actions: [
        CallInvitationButton(
            partnerIds: [chat.chatPartnerId],
            partnerNames: [chat.name],
            isVideo: true),
        CallInvitationButton(
            partnerIds: [chat.chatPartnerId],
            partnerNames: [chat.name],
            isVideo: false),
        BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return PopupMenuButton<String>(
                color: theme.scaffoldBackgroundColor,
                key: menuKey,
                onSelected: (String value) async {
                  if (value == 'Delete Chat') {
                    await defaultLoading(
                      context: context,
                        asyncFunction: ChatCubit.get(context).deleteChat(chat));
                    Get.back();
                  } else{
                    await defaultLoading(
                        context: context,
                        asyncFunction: ChatCubit.get(context).clearChat(chat.chatId));
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
