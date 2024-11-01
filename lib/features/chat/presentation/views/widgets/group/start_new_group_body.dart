import 'package:chat_app/core/shared_widgets/default_floating_button.dart';
import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'start_new_group_row.dart';

class StartNewGroupBody extends StatelessWidget {
  const StartNewGroupBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ChatCubit cubit = ChatCubit.get(context);
            ThemeData theme = Theme.of(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: theme.scaffoldBackgroundColor,
                toolbarHeight: 70.h,
                iconTheme: IconThemeData(color: theme.primaryColorDark),
                shape: const Border(bottom: BorderSide(color: Colors.grey)),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Group',
                      style:
                          Fonts.font20.copyWith(color: theme.primaryColorDark),
                    ),
                    Text(
                      cubit.groupMembers.isEmpty
                          ? 'Add members'
                          : '${cubit.groupMembers.length} selected from total 25',
                      style:
                          Fonts.font14.copyWith(color: theme.primaryColorDark),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10.w, height: 70.h),
                        GestureDetector(
                          onTap: () {
                            cubit.pickMedia();
                          },
                          child: CircleAvatar(
                            radius: 30.sp,
                            backgroundColor: theme.canvasColor,
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 25.sp,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        SizedBox(
                          width: 260.w,
                          child: DefaultDormField(
                              controller: controller,
                              type: TextInputType.text,
                              validate: (String? value) {
                                return null;
                              },
                              label: '',
                              hint: 'enter the Group Name (optional)',
                              filledColor: Colors.transparent,
                              autofocus: true,
                              hasBorders: false),
                        )
                      ],
                    ),
                    SizedBox(height: 5.h),
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
                tooltip: 'start',
                onPressed: () {
                  cubit.startNewGroup(controller.text);
                },
                icon: Icons.check,
              ),
              resizeToAvoidBottomInset: true,
            );
          }),
    );
  }
}
