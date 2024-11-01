import 'package:chat_app/core/shared_widgets/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatLoadingList extends StatelessWidget {
  const ChatLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                ShimmerCard(height: 60.w, width: 60.w,borderRadius: 30.r,),
                SizedBox(width: 20.w),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      SizedBox(height: 10.h,),
                      SizedBox(
                        width: 245.w,
                        child: Row(
                          children: [
                            ShimmerCard(height: 15.h, width: 100.w),
                            const Spacer(),
                            ShimmerCard(height: 10.h, width: 30.w),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.w),
                      ShimmerCard(height: 10.h, width: 180.w),
                    ]
                ),
              ]
          ),
        );
      },
      itemCount: 7,
    );
  }
}
