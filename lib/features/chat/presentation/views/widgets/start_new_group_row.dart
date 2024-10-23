import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartNewGroupRow extends StatefulWidget {
  final UserModel userModel;
  const StartNewGroupRow({
    super.key,
    required this.userModel,
  });

  @override
  State<StartNewGroupRow> createState() => _StartNewGroupRowState();
}

class _StartNewGroupRowState extends State<StartNewGroupRow> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              ChatCubit.get(context).updateGroupMembers(widget.userModel, isSelected);
              setState(() {
                isSelected=!isSelected;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .05, vertical: screenHeight * .01),
              child: Row(
                spacing: screenWidth * .05,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        foregroundImage: CachedNetworkImageProvider(widget.userModel.image),
                      ),
                      if(isSelected)
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.mainColor,
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 9,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    widget.userModel.name,
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
