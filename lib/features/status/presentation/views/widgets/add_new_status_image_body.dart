import 'dart:io';
import 'package:chat_app/core/shared_widgets/default_form_field.dart';
import 'package:chat_app/core/shared_widgets/default_loading.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: BlocProvider(
        create: (context) => StatusCubit(),
        child: BlocConsumer<StatusCubit, StatusStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.fromLTRB(8.w,
                    15.h, 8.w, 30.h),
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
                        8.w,
                        15.h,
                        8.w,
                        30.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 270.w,
                            child: DefaultDormField(
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
                            height: 65.w,
                            minWidth: 65.w,
                            shape: const CircleBorder(),
                            color: Colors.blueGrey.shade700,
                            onPressed: () {
                              StatusModel statusModel = StatusModel(
                                  'hi',
                                  controller.text,
                                  null,
                                  null,
                                  10,
                                  Timestamp.now());
                              defaultLoading(
                                context: context,
                                  asyncFunction: StatusCubit.get(context)
                                      .addNewStatus(statusModel, true));
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
      ),
    );
  }
}
