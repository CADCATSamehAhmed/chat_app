import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_widgets/default_floating_button.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_x;
import 'add_new_group_settings.dart';
import 'start_new_group_row.dart';

class StartNewGroupBody extends StatelessWidget {
  const StartNewGroupBody({super.key});

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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Group',
                    style: Fonts.font20,
                  ),
                  Text(
                    cubit.groupMembers.isEmpty
                        ? 'Add members'
                        : '${cubit.groupMembers.length} selected from total 25',
                    style: Fonts.font14,
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StartNewGroupRow(userModel: cubit.users[index]);
                    },
                  )
                ],
              ),
            ),
            floatingActionButton: DefaultFloatingButton(
              tooltip: 'next',
              onPressed: () {
                get_x.Get.to(()=>const AddNewGroupSettings(),transition: get_x.Transition.rightToLeft);
              },
              icon: Icons.arrow_forward,
            ),
            resizeToAvoidBottomInset: true,
          );
        });
  }
}
