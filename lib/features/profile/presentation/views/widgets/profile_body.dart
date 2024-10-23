import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/edit_field.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/profile_image.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          nameController.text = cubit.userModel.name;
          phoneController.text = cubit.userModel.phone;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImage(
                imageUrl: cubit.userModel.image,
              ),
              Container(
                height: screenWidth * .002,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * .05,
                    screenHeight * .05, screenWidth * .05, 0),
                child: Text(
                  'Name',
                  style: Fonts.font14.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              EditField(
                controller: nameController,
                text: 'name',
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * .05,
                    screenHeight * .05, screenWidth * .05, 0),
                child: Text(
                  'Phone',
                  style: Fonts.font14.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              EditField(
                controller: phoneController,
                text: 'phone',
              ),
              SaveButton(
                submit: () {
                  cubit.updateProfile(
                      nameController.text, phoneController.text);
                },
              ),
            ],
          );
        });
  }
}
