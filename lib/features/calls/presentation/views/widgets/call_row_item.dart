import 'package:chat_app/core/constants/variables.dart';
import 'package:flutter/material.dart';

class CallRowItem extends StatelessWidget {
  const CallRowItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * .05, vertical: screenHeight * .01),
      child: Row(
        spacing: screenWidth * .05,
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
