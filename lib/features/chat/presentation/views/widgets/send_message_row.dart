import 'package:chat_app/core/shared_widgets/default_floating_button.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/data/models/group_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendMessageRow extends StatefulWidget {
  final bool isGroup;
  final ChatModel? chat;
  final GroupModel? group;
  final TextEditingController controller;
  final ScrollController scrollController;
  final String? senderName;
  final String? senderImage;

  const SendMessageRow(
      {super.key,
      required this.isGroup,
      this.group,
      this.chat,
      required this.controller,
      required this.scrollController,
      this.senderName,
      this.senderImage});

  @override
  State<SendMessageRow> createState() => _SendMessageRowState();
}

class _SendMessageRowState extends State<SendMessageRow> {
  IconData sendIcon = Icons.keyboard_voice;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ChatCubit cubit = ChatCubit.get(context);
        return Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(25.r),
                  // border: Border.all(color: Theme.of(context).primaryColorDark),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await cubit.pickMedia();
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 25.sp,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  SizedBox(
                    width: 245.w,
                    child: TextFormField(
                      controller: widget.controller,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 5,
                      cursorColor: Theme.of(context).primaryColor,
                      onChanged: (String text) {
                        setState(() {
                          if (text != '') {
                            sendIcon = Icons.send;
                          } else {
                            sendIcon = Icons.keyboard_voice;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Message",
                        hintStyle: Fonts.font20.copyWith(color: Colors.grey),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  DefaultFloatingButton(
                    mini: true,
                    icon: sendIcon,
                    width: 55.w,
                    height: 55.w,
                    onPressed: () {
                    if (widget.controller.text != '') {
                      cubit.sendMessage(widget.isGroup, widget.chat, widget.group, widget.controller, widget.scrollController, widget.senderName, widget.senderImage);
                      setState(() {
                        sendIcon = Icons.keyboard_voice;
                      });
                    }
                  },),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
