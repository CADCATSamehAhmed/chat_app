import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/data/models/statuses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusAppbar extends StatelessWidget {
  final StatusesModel statuses;
  final String statusDate;
  const StatusAppbar({super.key, required this.statuses, required this.statusDate});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 10.w,
      right: 10.w,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: Colors.white,
              )),
          SizedBox(width: 10.w),
          CircleAvatar(
            radius: 25.r,
            foregroundImage: CachedNetworkImageProvider(statuses.image),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statuses.name,
                style: Fonts.font18.copyWith(
                    color: Colors.white, decoration: TextDecoration.none),
              ),
              SizedBox(height: 5.h),
              Text(
                statusDate,
                style: Fonts.font14.copyWith(
                    color: Colors.grey.shade400,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          SizedBox(width: 10.w),
          const Spacer(),
          SizedBox(width: 10.w),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}