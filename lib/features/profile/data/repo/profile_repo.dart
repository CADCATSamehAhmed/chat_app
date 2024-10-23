import 'dart:io';

import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepo {
  static String? myId = uid;
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<UserModel?> getProfileData() async {
      final document = await users.doc(myId).get();
      if(document.exists) {
        UserModel profileData = UserModel.fromJson(document.data()! as Map<String, dynamic>);
        print("sure i got user data of:${profileData.name}");
        print(profileData.uid);
        print(profileData.email);
        print(profileData.phone);
        print(profileData.image);
        return profileData;
      }
      else {
        print("can't get user data");
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

  Future<void> updateProfileData(String name,String phone,PlatformFile image) async {
    try {
      String? newImageUrl = await uploadImage(image);
      if(newImageUrl != null){
        await users.doc(myId).update({'name':name,'phone':phone,'image':newImageUrl});
        print("yup, user data updated");
      }
      else{
        print("sorry can't upload the image:$newImageUrl");
      }
    } catch (error) {
      print("sorry can't update user data:$error");
    }
  }
}
