import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_color.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:chat_app/features/status/presentation/views/show_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_x;
import 'add_new_status_text_body.dart';

class MyStatusRow extends StatelessWidget {
  final StatusModel? lastStatus;

  const MyStatusRow({
    super.key,required this.lastStatus,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusCubit, StatusStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StatusCubit cubit = StatusCubit.get(context);
          return InkWell(
            onTap: () {
              if (lastStatus == null) {
                get_x.Get.to(
                  () => const AddNewStatusTextBody(),
                  transition: get_x.Transition.rightToLeft,
                );
              } else {
                get_x.Get.to(
                  () => ShowStatusView(
                    statuses: cubit.myStatus!,
                  ),
                  transition: get_x.Transition.rightToLeft,
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * .05, vertical: screenWidth * .02),
              child: Row(
                spacing: screenWidth * .05,
                children: [
                  if (lastStatus == null)
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        BlocConsumer<ProfileCubit, ProfileStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              String image = ProfileCubit.get(context).userModel.image;
                              return CircleAvatar(
                                radius: 35,
                                foregroundImage: CachedNetworkImageProvider(image),
                              );
                            }),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColors.mainColor,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 15,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (lastStatus != null)
                    Container(
                      height: screenWidth * .2,
                      width: screenWidth * .2,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.mainColor, width: 3),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: screenWidth * .09,
                        backgroundColor: MyCustomColor.getStatusBgColor(lastStatus!.textBGColorIndex),
                        backgroundImage: lastStatus!.media != null
                            ? CachedNetworkImageProvider(lastStatus!.media!)
                            : null,
                        child: lastStatus!.text != null
                            ? Padding(
                              padding: EdgeInsets.all(screenWidth * .01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        lastStatus!.text,
                                        overflow: TextOverflow.clip,
                                        maxLines: 4,
                                        style: Fonts.font14.copyWith(
                                            fontSize: 8, color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            )
                            : null,
                      ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Status",
                        style:
                            Fonts.font18.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        lastStatus == null
                            ? "Tap to add status update"
                            : lastStatus!.date,
                        style: Fonts.font14.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
