import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/chat_loading_list.dart';
import 'widgets/chat/chat_window.dart';

class ChatsBody extends StatelessWidget {
  const ChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return StreamBuilder<List<ChatModel>>(
            stream: cubit.getChatsNew(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ChatModel>> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const ChatLoadingList();
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Something went wrong'));
              } else if (!snapshot.hasData) {
                return const Center(
                    child: Text('You have not chats yet'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.chats.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatWindow(chat: cubit.chats[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
