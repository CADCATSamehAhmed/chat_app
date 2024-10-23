import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  String uid = '';
  String error = '';
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      {required String id,
      required String name,
      required String email,
      required String phone}) async {
    await users.doc(id).set({
      'uid': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image':'https://firebasestorage.googleapis.com/v0/b/chatapp-fd0a7.appspot.com/o/statusesImages%2Fuser.png?alt=media&token=242f098e-efb1-45cc-b492-3f4d7057f82f'
    });
  }

  Future<int> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      UserCredential response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUser(
          id: response.user!.uid, name: name, email: email, phone: phone);
      uid = response.user!.uid;
      return 200;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 402;
      } else if (e.code == 'email-already-in-use') {
        return 403;
      }else{
        error = e.message!;
        return 404;
      }
    }
  }

  Future<int> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      uid = response.user!.uid;
      return 200;
    } on FirebaseAuthException catch (e) {
      if (e.message == 'wrong-password') {
        return 400;
      } else if (e.code == 'user-not-found') {
        return 401;
      }else{
        error = e.message!;
        return 404;
      }
    }
  }
}
