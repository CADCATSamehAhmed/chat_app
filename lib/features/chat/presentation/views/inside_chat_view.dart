import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/inside_chat_body.dart';
import 'widgets/chat_appbar.dart';
import 'package:flutter/material.dart';

class InsideChatView extends StatelessWidget {
  final ChatModel chat;
  const InsideChatView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      appBar: chatAppBar(chat: chat),
      body: InsideChatBody(chat: chat,),
      resizeToAvoidBottomInset: true,
    );
  }
}
