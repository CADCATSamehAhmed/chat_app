import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

PreferredSizeWidget chatAppBar({
  required ChatModel chat,
}) {
  return AppBar(
    toolbarHeight: screenHeight * .11,
    backgroundColor: AppColors.appBarBackGroundColor,
    shape: const Border(bottom: BorderSide(color: Colors.grey)),
    leading: Row(
      spacing: screenWidth * .01,
      children: [
        BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  ChatCubit.get(context).closeChat(chat.chatId);
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              );
            }),
        CircleAvatar(
          radius: 20,
          foregroundImage: CachedNetworkImageProvider(chat.image),
        ),
        Text(
          chat.name,
          style: Fonts.font18,
        ),
      ],
    ),
    leadingWidth: screenWidth * .65,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.video_chat,
          color: Colors.black,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.call,
          color: Colors.black,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
      ),
    ],
  );
}
