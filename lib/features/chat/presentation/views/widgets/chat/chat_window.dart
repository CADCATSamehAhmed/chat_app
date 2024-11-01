import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_datetime.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/inside_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as g;

class ChatWindow extends StatelessWidget {
  final ChatModel chat;

  const ChatWindow({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              g.Get.to(() => InsideChatView(chat: chat), transition: g.Transition.leftToRight);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        foregroundImage: CachedNetworkImageProvider(chat.image),
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 245.w,
                            child: Row(
                              children: [
                                Text(
                                  chat.name,
                                  style: Fonts.font20.copyWith(fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                                ),
                                const Spacer(),
                                Text(
                                  chat.timestamp != null
                                      ? MyCustomDateTime.getTimeSmart(chat.timestamp.toDate())
                                      : '',
                                  style: Fonts.font12,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 225.w,
                            child: Text(
                              chat.lastMessage ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: Fonts.font18.copyWith(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  if (chat.newMessagesNumber > 0)
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: CircleAvatar(
                        radius: 10.r,
                        backgroundColor:theme.primaryColor,
                        child: Text(
                          '${chat.newMessagesNumber}',
                          style: Fonts.font12.copyWith(color: theme.primaryColorDark),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
