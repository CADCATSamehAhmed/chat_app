import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartNewChatRow extends StatelessWidget {
  final UserModel userModel;

  const StartNewChatRow({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return InkWell(
              onTap: () {
                ChatCubit.get(context).startNewChat(userModel);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.sp,
                      foregroundImage:
                          CachedNetworkImageProvider(userModel.image),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      userModel.name,
                      style: Fonts.font20.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
