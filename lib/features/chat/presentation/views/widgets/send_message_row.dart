import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageRow extends StatelessWidget {
  final ChatModel chat;
  final TextEditingController controller;
  final ScrollController scrollController;

  const SendMessageRow(
      {super.key, required this.controller, required this.chat, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Row(
            spacing: screenWidth * .02,
            children: [
              Container(
                width: screenWidth * .8,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  spacing: screenWidth * .01,
                  children: [
                    const Expanded(
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * .52,
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
                        cursorColor: AppColors.mainColor,
                        onChanged: (s) {
                          cubit.changSendIcon(controller.text);
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
                    const Expanded(
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await cubit.pickMedia();
                        },
                        child:const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                color: AppColors.mainColor,
                shape: const CircleBorder(),
                minWidth: screenWidth * .15,
                height: screenWidth * .15,
                onPressed: () {
                  if (controller.text != '') {
                    cubit.sendMessage(chat, controller,scrollController);
                  }
                },
                child: Center(
                  child: Icon(
                    cubit.sendIcon,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
