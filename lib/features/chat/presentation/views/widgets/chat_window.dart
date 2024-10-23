import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/inside_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;

class ChatWindow extends StatelessWidget {
  final ChatModel chat;

  const ChatWindow({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              g.Get.to(() => InsideChatView(chat: chat,),
                  transition: g.Transition.leftToRight);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .05, vertical: screenHeight * .01),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Row(
                    spacing: screenWidth * .05,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        foregroundImage: CachedNetworkImageProvider(chat.image),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.name,
                            style:
                                Fonts.font20.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: screenWidth*.6,
                            child: Text(
                              chat.lastMessage??'',
                              overflow: TextOverflow.ellipsis,
                              style: Fonts.font18,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat.lastMessageDate??'',
                        style: Fonts.font12,
                      ),
                      SizedBox(
                        height: screenWidth * .04,
                      ),
                      if (chat.newMessagesNumber > 0)
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.mainColor,
                          child: Text(
                            '${chat.newMessagesNumber}',
                            style: Fonts.font12.copyWith(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
