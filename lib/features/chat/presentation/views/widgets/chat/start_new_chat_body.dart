import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/chat/start_new_chat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartNewChatBody extends StatelessWidget {
  const StartNewChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => ChatCubit()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          toolbarHeight: 70.h,
          iconTheme: IconThemeData(color: theme.primaryColorDark),
          shape: const Border(bottom: BorderSide(color: Colors.grey)),
          title: Text(
            'People you may know',
            style: Fonts.font23.copyWith(color: theme.primaryColorDark),
          ),
        ),
        body: BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ChatCubit cubit = ChatCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (state is GetAllUsersLoadingState)
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  if (state is GetAllUsersSuccessState)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StartNewChatRow(userModel: cubit.users[index]);
                      },
                    )
                ],
              ),
            );
          },
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
