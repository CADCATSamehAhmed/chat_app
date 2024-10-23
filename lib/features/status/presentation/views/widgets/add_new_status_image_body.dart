import 'dart:io';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_datetime.dart';
import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddNewStatusImageBody extends StatelessWidget {
  final File file;

  const AddNewStatusImageBody({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Form(
      child: BlocConsumer<StatusCubit, StatusStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.fromLTRB(screenWidth * .02,
                  screenHeight * .02, screenWidth * .02, screenHeight * .04),
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: FileImage(file), fit: BoxFit.contain)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * .02,
                      screenHeight * .02,
                      screenWidth * .02,
                      screenHeight * .04),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.75,
                          child: defaultFormField(
                              controller: controller,
                              type: TextInputType.text,
                              validate: (v) {
                                return null;
                              },
                              label: null,
                              hint: "Add Description...",
                              filledColor: Colors.grey.shade700),
                        ),
                        MaterialButton(
                          height: screenWidth * 0.18,
                          minWidth: screenWidth * 0.18,
                          shape: const CircleBorder(),
                          color: Colors.blueGrey.shade700,
                          onPressed: () async {
                            StatusModel statusModel = StatusModel(
                                MyCustomDateTime.getCurrentTime(),
                                'hi',
                                controller.text,
                                null,
                                null,
                                10,
                                Timestamp.now());
                            await StatusCubit.get(context)
                                .addNewStatus(statusModel,true);
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
