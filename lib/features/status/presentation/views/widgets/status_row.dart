import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_color.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:chat_app/features/status/presentation/views/show_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;

class StatusRow extends StatelessWidget {
  final StatusesModel statuses;
  final StatusModel lastStatus;
  final bool isWatched;

  const StatusRow(
      {super.key,
      required this.statuses,
      required this.lastStatus,
      required this.isWatched});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        g.Get.to(
          () => ShowStatusView(
            statuses: statuses,
          ),
          transition: g.Transition.rightToLeft,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * .05, vertical: screenWidth * .02),
        child: Row(
          spacing: screenWidth * .05,
          children: [
            BlocConsumer<StatusCubit, StatusStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Container(
                    height: screenWidth * .2,
                    width: screenWidth * .2,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color:
                                isWatched ? Colors.grey : AppColors.mainColor,
                            width: 3),
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: screenWidth * .09,
                      backgroundColor: MyCustomColor.getStatusBgColor(
                          lastStatus.textBGColorIndex),
                      foregroundImage: lastStatus.media != null
                          ? CachedNetworkImageProvider(lastStatus.media!)
                          : null,
                      child: lastStatus.text != null
                          ? Padding(
                              padding: EdgeInsets.all(screenWidth * .01),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      lastStatus.text!,
                                      overflow: TextOverflow.fade,
                                      style: Fonts.font14.copyWith(
                                          fontSize: 8, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                  );
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statuses.name,
                  style: Fonts.font18.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  lastStatus.date,
                  style: Fonts.font14.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
