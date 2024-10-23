import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/status/data/models/status_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:get/get.dart';

class StatusRepo {
  List<StatusModel> getStatus(QuerySnapshot<Object?>? data) {
    List<StatusModel> status = [];
    if (data != null) {
      data.docs.forEach((DocumentSnapshot document) {
        if (document.id != uid) {
          status.add(
              StatusModel.fromJson(document.data()! as Map<String, dynamic>));
        }
      });
    }
    return status;
  }

  Future<String?> uploadMedia(PlatformFile image) async {
    try {
      UploadTask? uploadTask;
      final file = File(image.path!);
      final path = 'statusesImages/($uid)/${image.name}';
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return urlDownload;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addStatus(StatusModel status,bool statusIsMedia,{PlatformFile? media}) async {
    try {
      if(statusIsMedia){
        String? newImageUrl = await uploadMedia(media!);
        status.media=newImageUrl;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('statuses')
          .add(status.toMap());
      print("add Status successfully");
      Get.back();
    } catch (error) {
      print("can't add Status:$error");
    }
  }
}
