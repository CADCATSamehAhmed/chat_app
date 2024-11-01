import 'dart:io';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/data/models/group_message_model.dart';
import 'package:chat_app/features/chat/data/models/group_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/chat/presentation/views/inside_chat_view.dart';
import 'package:chat_app/features/chat/presentation/views/inside_group_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ChatsRepo {
  static var usersCollection = FirebaseFirestore.instance.collection('users');
  static var chatsCollection = FirebaseFirestore.instance.collection('chats');

  Future<Map<String, dynamic>> getOtherUserData(String otherUserId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await usersCollection.doc(otherUserId).get();
    return userSnapshot.data()!;
  }

  Future<Map<String, dynamic>>? getLastMessageData(String chatId) async {
    QuerySnapshot<Map<String, dynamic>> messageSnapshot = await chatsCollection
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
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      Map<String, Map<String, dynamic>> cachedUserData = {};
      for (var doc in snapshot.docs) {
        String chatPartnerId = doc['chatPartnerId'];
        String chatId = doc['chatId'];
        Map<String, dynamic> otherUserData =
            await getOtherUserData(chatPartnerId);
        cachedUserData[chatPartnerId] = otherUserData;
        final lastMessageData = await getLastMessageData(chatId);
        if (doc.data().isNotEmpty && lastMessageData != null) {
          ChatModel chatModel = ChatModel.fromJson(
            doc.data(),
            cachedUserData[chatPartnerId]!['name'],
            cachedUserData[chatPartnerId]!['image'],
            lastMessageData['message'],
            lastMessageData['date'],
          );
          chats.add(chatModel);
        }
      }
      return chats.isNotEmpty ? chats : [];
    });
  }

  Stream<List<GroupModel>> getGroups() {
    List<GroupModel> groups = [];
    return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('groups')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      for (var doc in snapshot.docs) {
        String groupId = doc['groupId'];

        final lastMessageData = await getLastMessageData(groupId);
        MessageModel? lastMessage;

        if (doc.data().isNotEmpty) {
          if (lastMessageData!.isNotEmpty) {
            lastMessage = MessageModel.fromJson(lastMessageData);
          }
          groups.add(GroupModel.fromJson(
            doc.data(),
            lastMessage,
          ));
        }
      }
      return groups.isNotEmpty ? groups : [];
    });
  }

  List<MessageModel> getMessages(QuerySnapshot<Object?>? data) {
    List<MessageModel> messages = [];
    if (data != null) {
      for (var document in data.docs) {
        messages.add(
            MessageModel.fromJson(document.data()! as Map<String, dynamic>));
      }
    }
    return messages;
  }

  List<GroupMessageModel> getGroupMessages(QuerySnapshot<Object?>? data) {
    List<GroupMessageModel> messages = [];
    if (data != null) {
      for (var document in data.docs) {
        messages.add(GroupMessageModel.fromJson(
            document.data()! as Map<String, dynamic>));
      }
    }
    return messages;
  }

  Future<bool> sendMessage(
      String chatId, String receiverId, MessageModel message) async {
    try {
      await chatsCollection
          .doc(chatId)
          .collection('messages')
          .add(message.toMap());
      late int newMessagesNumber;
      await usersCollection
          .doc(receiverId)
          .collection('chats')
          .doc(chatId)
          .get()
          .then((e) {
        newMessagesNumber = e.get('newMessagesNumber');
      });
      await usersCollection
          .doc(receiverId)
          .collection('chats')
          .doc(chatId)
          .update({
        'newMessagesNumber': newMessagesNumber + 1,
        'timestamp': message.timestamp
      });
      await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats')
          .doc(chatId)
          .update({'timestamp': message.timestamp});
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> sendGroupMessage(String groupId, List<dynamic> partnersIds,
      GroupMessageModel message) async {
    try {
      await chatsCollection
          .doc(groupId)
          .collection('messages')
          .add(message.toMap());
      late int newMessagesNumber;
      for (var partnerId in partnersIds) {
        if (partnerId == uid) {
          break;
        }
        await usersCollection
            .doc(partnerId)
            .collection('groups')
            .doc(groupId)
            .get()
            .then((e) {
          newMessagesNumber = e.get('newMessagesNumber');
        });
        await usersCollection
            .doc(partnerId)
            .collection('groups')
            .doc(groupId)
            .update({
          'newMessagesNumber': newMessagesNumber + 1,
          'timestamp': message.timestamp
        });
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updateChat(bool isGroup, String chatId) async {
    try {
      if (isGroup) {
        await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('groups').doc(chatId).update({'newMessagesNumber': 0});
      } else {
        await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats').doc(chatId).update({'newMessagesNumber': 0});
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    try {
      QuerySnapshot<Object?> docRef =
          await FirebaseFirestore.instance.collection('users').get();
      for (var document in docRef.docs) {
        if (document.id != uid) {
          allUsers.add(
              UserModel.fromJson(document.data()! as Map<String, dynamic>));
        }
      }
    } catch (error) {
      allUsers = [];
    }
    return allUsers;
  }

  Future<bool> startNewChat(UserModel userData) async {
    try {
      DocumentReference docRef = await chatsCollection.add({});
      ChatModel newChat = ChatModel(docRef.id, userData.uid, 0,
          FieldValue.serverTimestamp(), userData.name, userData.image);
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats').doc(docRef.id).set(newChat.toMap());
      newChat.chatPartnerId = uid!;
      await usersCollection
          .doc(userData.uid)
          .collection('chats')
          .doc(docRef.id)
          .set(newChat.toMap());
      Get.off(() => InsideChatView(chat: newChat),
          transition: Transition.leftToRight);
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> startNewGroup(String groupName, PlatformFile selectedImage,
      List<String> partnersIds) async {
    try {
      DocumentReference docRef = await chatsCollection.add({});
      String? groupImage =
          await uploadMedia('groups/$uid/${selectedImage.name}', selectedImage);
      GroupModel groupModel = GroupModel(
        docRef.id,
        partnersIds,
        uid!,
        partnersIds.length,
        FieldValue.serverTimestamp(),
        groupName,
        groupImage!,
      );

      // await chatsCollection.doc(docRef.id).collection('messages').add(
      //     MessageModel(
      //             senderId: 'system',
      //             message: 'you make $groupName group at $',
      //             timestamp: timestamp,
      //             date: date)
      //         .toMap());
      for (var partner in partnersIds) {
        await usersCollection
            .doc(partner)
            .collection('groups')
            .doc(docRef.id)
            .set(groupModel.toMap());
      }
      Get.off(() => InsideGroupView(group: groupModel),
          transition: Transition.leftToRight);
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> uploadMedia(String path, PlatformFile image) async {
    try {
      UploadTask? uploadTask;
      final file = File(image.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      return urlDownload;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteChat(ChatModel chat) async {
    try {
      await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('chats').doc(chat.chatId).delete();
      await usersCollection
          .doc(chat.chatPartnerId)
          .collection('chats')
          .doc(chat.chatId)
          .delete();
      await chatsCollection.doc(chat.chatId).delete();
      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> clearChat(String id) async {
    try {
      await usersCollection
          .doc(uid)
          .collection('chats')
          .doc(id)
          .delete();
      await chatsCollection.doc(id).delete();
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
