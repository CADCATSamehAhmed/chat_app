import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_color.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_datetime.dart';
import 'package:chat_app/core/themes/colors.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:chat_app/features/status/presentation/view_model/status_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewStatusTextBody extends StatefulWidget {
  const AddNewStatusTextBody({
    super.key,
  });

  @override
  State<AddNewStatusTextBody> createState() => _AddNewStatusTextBodyState();
}

class _AddNewStatusTextBodyState extends State<AddNewStatusTextBody> {
  TextEditingController controller = TextEditingController();
  int colorIndex = 0;
  Color backgroundColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                setState(() {
                  if (colorIndex < 6) {
                    colorIndex++;
                  } else {
                    colorIndex = 0;
                  }
                  backgroundColor = MyCustomColor.getStatusBgColor(colorIndex)!;
                });
              },
              child: const Icon(
                Icons.color_lens,
                color: Colors.white,
              )),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              cursorColor: AppColors.mainColor,
              textAlign: TextAlign.center,
              maxLines: 10,
              minLines: 1,
              style: Fonts.font25.copyWith(color: Colors.grey.shade300),
              decoration: InputDecoration(
                hintText: "Type Status",
                hintStyle: Fonts.font25.copyWith(color: Colors.grey.shade300),
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
          ],
        ),
        floatingActionButton: MaterialButton(
          height: screenWidth * 0.18,
          minWidth: screenWidth * 0.18,
          shape: const CircleBorder(),
          color: Colors.blueGrey.shade700,
          onPressed: () async{
            StatusModel statusModel = StatusModel(
                MyCustomDateTime.getCurrentTime(),
                null,
                null,
                controller.text,
                colorIndex,
                5,
                Timestamp.now());
            await StatusCubit.get(context).addNewStatus(statusModel,false);
          },
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
