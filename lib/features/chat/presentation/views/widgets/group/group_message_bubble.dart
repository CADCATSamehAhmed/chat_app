import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_datetime.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/group_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupMessageBubble extends StatelessWidget {
  final GroupMessageModel messageModel;
  const GroupMessageBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: messageModel.senderId == uid
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: messageModel.senderId == uid
                    ? theme.primaryColor
                    : Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topRight: messageModel.senderId == uid
                      ? Radius.circular(10.r)
                      : const Radius.circular(0),
                  topLeft: messageModel.senderId == uid
                      ? const Radius.circular(0)
                      : Radius.circular(10.r),
                  bottomLeft:  Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min, // Ensures bubble size fits content
                children: [
                  if(messageModel.senderId != uid)
                    Flexible(
                      child: Text(
                        messageModel.senderName,
                        style: Fonts.font18.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  Flexible(
                    child: Text(
                      messageModel.message,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis, // Handles text overflow
                      style: Fonts.font18.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    MyCustomDateTime.getTime(messageModel.timestamp.toDate()),
                    style: Fonts.font12.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.w,),
            if(messageModel.senderId != uid)
              CircleAvatar(
                radius: 25.r,
                foregroundImage: CachedNetworkImageProvider(messageModel.senderImage),
              ),
          ],
        ),
      ),
    );
  }
}
