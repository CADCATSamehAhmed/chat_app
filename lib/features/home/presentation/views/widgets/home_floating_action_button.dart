import 'package:chat_app/core/shared_widgets/default_floating_button.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/start_new_chat_body.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:chat_app/features/status/presentation/views/widgets/add_new_status_text_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;

class HomeFloatingActionButton extends StatelessWidget {
  final int index;

  const HomeFloatingActionButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultFloatingButton(
            tooltip: 'start new chat',
            onPressed: () {
              ChatCubit.get(context).getUsers();
              g.Get.to(()=>const StartNewChatBody(),transition: g.Transition.rightToLeft);
            },
            icon: Icons.chat,
          );
        },
      );
    } else if (index == 1) {
      return BlocConsumer<StatusCubit, StatusStates>(
          listener: (context, state) {},
          builder: (context, state) {
          return Column(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultFloatingButton(
                heroTag: 'NewTextStatusTag',
                tooltip: 'type text status',
                mini: true,
                onPressed: () {
                  g.Get.to(() => const AddNewStatusTextBody(),
                      transition: g.Transition.downToUp);
                },
                icon: Icons.chat,
              ),
              DefaultFloatingButton(
                tooltip: 'add media status',
                onPressed: () async {
                  await StatusCubit.get(context).pickMediaStatus();
                },
                backgroundColor: AppColors.mainColor,
                icon: Icons.camera_alt,
              ),
            ],
          );
        }
      );
    } else {
      return DefaultFloatingButton(
        tooltip: 'start call',
        onPressed: () {},
        icon: Icons.add_call,
      );
    }
  }
}
