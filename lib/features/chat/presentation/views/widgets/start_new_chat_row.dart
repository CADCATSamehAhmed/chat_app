import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartNewChatRow extends StatelessWidget {
  final UserModel userModel;
  const StartNewChatRow({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
        return InkWell(
          onTap: () {
            ChatCubit.get(context).startNewChat(userModel);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .05, vertical: screenHeight * .01),
            child: Row(
              spacing: screenWidth * .05,
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundImage: CachedNetworkImageProvider(userModel.image),
                ),
                Text(
                  userModel.name,
                  style:
                  Fonts.font20.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
