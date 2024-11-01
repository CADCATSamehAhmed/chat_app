import 'dart:io';

import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepo {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<UserModel?> getProfileData() async {
      final document = await users.doc(uid).get();
      if(document.exists) {
        UserModel profileData = UserModel.fromJson(document.data()! as Map<String, dynamic>);
        return profileData;
      }
      else {
        return null;
      }
  }
  Future<String?> uploadImage(PlatformFile image) async {
    try{
      UploadTask? uploadTask;
      final file = File(image.path!);
      final path = 'profileImages/($uid)/${image.name}';
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return urlDownload;
    }catch(error){
      rethrow;
    }
  }

  Future<bool> updateProfileData(String name,String phone,PlatformFile image) async {
    try {
      String? newImageUrl = await uploadImage(image);
      if(newImageUrl != null){
        await users.doc(uid).update({'name':name,'phone':phone,'image':newImageUrl});
        return true;
      }
      else{
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
}
