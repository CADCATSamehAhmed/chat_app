import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {},
              builder: (context, state) {
                ProfileCubit cubit = ProfileCubit.get(context);
                ImageProvider<Object>? imageProvided = (cubit.pickedImage != null
                    ? FileImage(cubit.pickedImage!)
                    : CachedNetworkImageProvider(imageUrl)) as ImageProvider<Object>?;
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      foregroundImage: imageProvided,
                    ),
                    GestureDetector(
                      onTap:(){
                        cubit.pickProfileImage();
                      },
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.edit,
                          size: 15.sp,
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
