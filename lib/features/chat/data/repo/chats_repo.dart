import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/chat/presentation/views/inside_chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatsRepo {
  static String? myId = uid;

  Future<Map<String, dynamic>> getOtherUserData(String otherUserId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(otherUserId)
            .get();
    return userSnapshot.data()!;
  }

  Future<Map<String, dynamic>> getLastMessageData(String chatId) async {
    QuerySnapshot<Map<String, dynamic>> messageSnapshot =
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

    if (messageSnapshot.docs.isNotEmpty) {
      return messageSnapshot.docs.first.data();
    } else {
      return {};
    }
  }

  Stream<List<ChatModel>> getChatsNew() {
    List<ChatModel> chats = [];
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .asyncMap((snapshot) async {
      Map<String, Map<String, dynamic>> cachedUserData = {};

      for (var doc in snapshot.docs) {
        String chatPartnerId = doc['chatPartnerId'];
        String chatId = doc['chatId'];
        Map<String, dynamic> otherUserData =
            await getOtherUserData(chatPartnerId);
        cachedUserData[chatPartnerId] = otherUserData;

        final lastMessageSnapshot = await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get()
            .then((querySnapshot) => querySnapshot.docs.isNotEmpty
                ? querySnapshot.docs.first
                : null);

        if (doc.data().isNotEmpty && lastMessageSnapshot != null) {
          Map<String, dynamic> lastMessageData = lastMessageSnapshot.data();
          chats.add(ChatModel.fromJson(
            doc.data(),
            cachedUserData[chatPartnerId]!['name'],
            cachedUserData[chatPartnerId]!['image'],
            lastMessageData['message'],
            lastMessageData['date'],
          ));
        }
      }

      return chats.isNotEmpty ? chats : [];
    });
  }

  List<MessageModel> getMessages(QuerySnapshot<Object?>? data) {
    List<MessageModel> messages = [];
    if (data != null) {
      data.docs.forEach((DocumentSnapshot document) {
        messages.add(
            MessageModel.fromJson(document.data()! as Map<String, dynamic>));
      });
    }
    return messages;
  }

  Future<void> sendMessage(
      String chatId, String receiverId, MessageModel message) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toMap());
      late int newMessagesNumber;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(chatId)
          .get()
          .then((e) {
        newMessagesNumber = e.get('newMessagesNumber');
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(chatId)
          .update({'newMessagesNumber': newMessagesNumber + 1,'timestamp':message.timestamp});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .collection('chats')
          .doc(chatId)
          .update({'timestamp':message.timestamp});
      print("send message successfully");
    } catch (error) {
      print("can't send message:$error");
    }
  }

  Future<void> updateChat(String chatId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .collection('chats')
          .doc(chatId)
          .update({'newMessagesNumber': 0
      });
      print("update successfully");
    } catch (error) {
      print("cant update the chat:$error");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    try {
      QuerySnapshot<Object?> docRef =
          await FirebaseFirestore.instance.collection('users').get();
      docRef.docs.forEach((DocumentSnapshot document) {
        if (document.id != myId) {
          allUsers.add(
              UserModel.fromJson(document.data()! as Map<String, dynamic>));
        }
      });
    } catch (error) {
      allUsers = [];
    }
    return allUsers;
  }

  Future<void> startNewChat(UserModel userData) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('chats').add({});
      ChatModel newChat= ChatModel(docRef.id, userData.uid, 0, FieldValue.serverTimestamp(), userData.name, userData.image);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myId).get();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .collection('chats')
          .doc(docRef.id)
          .set(newChat.toMap());
      newChat.chatPartnerId=myId!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.uid)
          .collection('chats')
          .doc(docRef.id)
          .set(newChat.toMap());

      print("chat added successfully");
      Get.off(() => InsideChatView(chat: newChat),
          transition: Transition.leftToRight);
    } catch (error) {
      print("cant add the chat:$error");
    }
  }
}
