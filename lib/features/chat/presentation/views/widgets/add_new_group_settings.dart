import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/default_floating_button.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'start_new_group_row.dart';

class AddNewGroupSettings extends StatelessWidget {
  const AddNewGroupSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackGroundColor,
            appBar: AppBar(
              toolbarHeight: screenHeight * .1,
              backgroundColor: AppColors.appBarBackGroundColor,
              shape: const Border(bottom: BorderSide(color: Colors.grey)),
              title: Text(
                'New Group',
                style: Fonts.font25,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.groupMembers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StartNewGroupRow(userModel: cubit.groupMembers[index]);
                    },
                  )
                ],
              ),
            ),
            floatingActionButton: DefaultFloatingButton(
              tooltip: 'start',
              onPressed: () {},
              icon: Icons.check,
            ),
            resizeToAvoidBottomInset: true,
          );
        });
  }
}
