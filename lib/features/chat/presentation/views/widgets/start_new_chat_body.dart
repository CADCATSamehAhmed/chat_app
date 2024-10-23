import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/start_new_chat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartNewChatBody extends StatelessWidget {
  const StartNewChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      appBar: AppBar(
        toolbarHeight: screenHeight * .1,
        backgroundColor: AppColors.appBarBackGroundColor,
        shape: const Border(bottom: BorderSide(color: Colors.grey)),
        title: Text(
          'People you may know',
          style: Fonts.font23,
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              children: [
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
    );
  }
}
