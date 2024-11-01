import 'package:chat_app/features/chat/data/models/group_model.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/group/build_group_messages.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/send_message_row.dart';
import 'package:chat_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsideGroupBody extends StatelessWidget {
  final GroupModel group;

  const InsideGroupBody({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(group.groupId)
        .collection('messages')
        .orderBy('timestamp',
            descending:
                false) // Sort messages in ascending order (oldest to newest)
        .snapshots();
    TextEditingController controller = TextEditingController();
    ScrollController scrollController = ScrollController();
    GlobalKey key = GlobalKey();
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserData(),
      child: Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Stack(
            children: [
              BuildGroupMessages(
                messagesStream: messagesStream,
                scrollController: scrollController,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocConsumer<ProfileCubit, ProfileStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit  =ProfileCubit.get(context);
                    return SendMessageRow(
                      controller: controller,
                      group: group,
                      scrollController: scrollController,
                      isGroup: true,
                      senderName: cubit.userModel.name,
                      senderImage: cubit.userModel.image,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
