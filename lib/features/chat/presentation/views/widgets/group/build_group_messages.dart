import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/group/group_message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildGroupMessages extends StatefulWidget {
  final Stream<QuerySnapshot> messagesStream;
  final ScrollController scrollController;

  const BuildGroupMessages({
    super.key,
    required this.messagesStream, required this.scrollController,
  });

  @override
  State<BuildGroupMessages> createState() => _BuildGroupMessagesState();
}

class _BuildGroupMessagesState extends State<BuildGroupMessages> {
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
    super.initState();
    startState();
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
              cubit.getGroupMessages(snapshot.data);
              return ListView.builder(
                shrinkWrap: true,
                controller: widget.scrollController,
                padding: const EdgeInsets.only(bottom: 70.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GroupMessageBubble(messageModel: cubit.groupMessages[index]);
                },
                itemCount: cubit.groupMessages.length,
              );
            },
          );
        });
  }
}
