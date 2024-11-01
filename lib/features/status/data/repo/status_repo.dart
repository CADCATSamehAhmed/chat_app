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
      for (var document in data.docs) {
          status.add(StatusModel.fromJson(document.data()! as Map<String, dynamic>));
      }
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

  Future<bool> addStatus(StatusModel status,bool statusIsMedia,{PlatformFile? media}) async {
    try {
      if(statusIsMedia){
        String? newImageUrl = await uploadMedia(media!);
        status.media=newImageUrl;
      }
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('statuses').add(status.toMap());
      Get.back();
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
