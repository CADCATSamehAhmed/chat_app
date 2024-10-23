import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;

  const MessageBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: messageModel.senderId == uid
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: messageModel.senderId == uid
                ? AppColors.mainColor
                : Colors.blueGrey.shade700,
            borderRadius: BorderRadius.only(
              topRight: messageModel.senderId == uid
                  ? const Radius.circular(10)
                  : const Radius.circular(0),
              topLeft: messageModel.senderId == uid
                  ? const Radius.circular(0)
                  : const Radius.circular(10),
              bottomLeft: const Radius.circular(10),
              bottomRight: const Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min, // Ensures bubble size fits content
            children: [
              Flexible(
                child: Text(
                  messageModel.message,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis, // Handles text overflow
                  style: Fonts.font18.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 4), // Add a small gap between text and date
              Text(
                messageModel.date,
                style: Fonts.font12.copyWith(color: Colors.grey.shade300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
