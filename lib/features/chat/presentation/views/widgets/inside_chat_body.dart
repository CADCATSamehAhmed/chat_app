import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/build_chat_messages.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/send_message_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsideChatBody extends StatelessWidget {
  final ChatModel chat;
  const InsideChatBody({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false) // Sort messages in ascending order (oldest to newest)
        .snapshots();
    TextEditingController controller = TextEditingController();
    ScrollController scrollController = ScrollController();
    GlobalKey key = GlobalKey();
    return Form(
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .02),
        child: Stack(
          children: [
            BuildChatMessages(messagesStream: messagesStream, scrollController: scrollController,),
            Align(alignment: Alignment.bottomCenter, child: SendMessageRow(controller: controller, chat:chat, scrollController: scrollController,))
          ],
        ),
      ),
    );
  }
}
