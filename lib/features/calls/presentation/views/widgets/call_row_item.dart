import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallRowItem extends StatelessWidget {
  const CallRowItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: const Row(
        children: [
          // CircleAvatar(
          //   radius: 30,
          //   backgroundColor: Colors.grey,
          //   backgroundImage:
          //       chat.image != null ? NetworkImage(chat.image!) : null,
          //   child: Icon(
          //     Icons.person,
          //     color: chat.image == null ? Colors.white : Colors.transparent,
          //   ),
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       chat.name,
          //       style: Fonts.font20.copyWith(fontWeight: FontWeight.bold),
          //     ),
          //     SizedBox(
          //       width: screenWidth * .6,
          //       child: Text(
          //         chat.lastMessage,
          //         overflow: TextOverflow.ellipsis,
          //         style: Fonts.font18,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
