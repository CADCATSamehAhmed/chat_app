import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_bubble.dart';

class BuildChatMessages extends StatefulWidget {
  final Stream<QuerySnapshot> messagesStream;
  final ScrollController scrollController;

  const BuildChatMessages({
    super.key,
    required this.messagesStream, required this.scrollController,
  });

  @override
  State<BuildChatMessages> createState() => _BuildChatMessagesState();
}

class _BuildChatMessagesState extends State<BuildChatMessages> {
  startState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    startState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return StreamBuilder<QuerySnapshot>(
            stream: widget.messagesStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong', style: Fonts.font25));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No messages yet', style: Fonts.font25));
              }
              cubit.getChatMessages(snapshot.data);
              return ListView.builder(
                shrinkWrap: true,
                controller: widget.scrollController,
                padding: const EdgeInsets.only(bottom: 70.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MessageBubble(messageModel: cubit.messages[index]);
                },
                itemCount: cubit.messages.length,
              );
            },
          );
        });
  }
}
