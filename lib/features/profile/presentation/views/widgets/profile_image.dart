import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * .04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {},
              builder: (context, state) {
                ProfileCubit cubit = ProfileCubit.get(context);
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * .16,
                      foregroundImage: cubit.pickedImage != null
                          ? FileImage(cubit.pickedImage!)
                          : CachedNetworkImageProvider(imageUrl),
                    ),
                    GestureDetector(
                      onTap:(){
                        cubit.pickProfileImage();
                      },
                      child: CircleAvatar(
                        radius: screenWidth * .04,
                        backgroundColor: AppColors.mainColor,
                        child: const Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
