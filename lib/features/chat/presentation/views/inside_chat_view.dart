import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/chat/inside_chat_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/chat/chat_appbar.dart';
import 'package:flutter/material.dart';

class InsideChatView extends StatelessWidget {
  final ChatModel chat;
  const InsideChatView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: ChatAppBar(chat: chat),
        body: InsideChatBody(chat: chat,),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
