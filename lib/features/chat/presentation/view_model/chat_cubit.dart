import 'dart:io';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/core/shared_prefences/functions/my_custom_datetime.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:chat_app/features/chat/data/repo/chats_repo.dart';
import 'package:chat_app/features/chat/presentation/views/inside_chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:get/get.dart' as get_x;

abstract class ChatStates {}
class ChatInitialState extends ChatStates {}
class ChatChangeSendIconState extends ChatStates {}
class GetChatsSuccessState extends ChatStates {}
class StartNewChatState extends ChatStates {}
class GetChatMessagesSuccessState extends ChatStates {}
class SendNewMessageState extends ChatStates {}
class CloseChatState extends ChatStates {}
class PickMediaSuccessState extends ChatStates {}
class PickMediaErrorState extends ChatStates {}
class GetAllUsersState extends ChatStates {}
class UpdateGroupMembersState extends ChatStates {}

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit? _chatCubit;
  ChatsRepo chatsRepo = ChatsRepo();
  List<ChatModel> chats = [];
  List<UserModel> users = [];
  List<UserModel> groupMembers = [];
  List<MessageModel> messages = [];
  IconData sendIcon = Icons.keyboard_voice;

  static ChatCubit get(context) {
    _chatCubit ??= BlocProvider.of(context);
    return _chatCubit!;
  }

  Stream<List<ChatModel>> getChatsNew() {
    return chatsRepo.getChatsNew().map((chatList) {
      chats = chatList;
      return chatList;
    });
  }

  void startNewChat(UserModel userData) {
    bool startNewChat = true;
    chats.forEach((ChatModel chat) {
      if (chat.chatPartnerId == userData.uid) {
        startNewChat = false;
        get_x.Get.off(() => InsideChatView(chat: chat), transition: get_x.Transition.leftToRight);
        return;
      }
    });
    if(startNewChat){
      chatsRepo.startNewChat(userData);
    }
    emit(StartNewChatState());
  }

  void getChatMessages(QuerySnapshot<Object?>? data) {
    messages = [];
    messages = chatsRepo.getMessages(data);
  }

  void sendMessage(ChatModel chat, TextEditingController controller,ScrollController scrollController) {
    String date = MyCustomDateTime.getCurrentTime();
    chatsRepo.sendMessage(chat.chatId, chat.chatPartnerId,
        MessageModel(uid!, controller.text, FieldValue.serverTimestamp(), date));
    controller.clear();
    sendIcon = Icons.keyboard_voice;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    emit(SendNewMessageState());
  }

  void changSendIcon(String text) {
    if (text != '') {
      sendIcon = Icons.send;
    } else {
      sendIcon = Icons.keyboard_voice;
    }
    emit(ChatChangeSendIconState());
  }

  void closeChat(String chatId) {
    chatsRepo.updateChat(chatId);
    emit(CloseChatState());
  }

  File? pickedMedia;
  PlatformFile? file;

  Future<void> pickMedia() async {
    pickedMedia = null;
    file = null;
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'png', 'mp4']);
    file = result?.files.first;
    if (result != null) {
      pickedMedia = File(result.files.single.path!);
      emit(PickMediaSuccessState());
    } else {
      emit(PickMediaErrorState());
    }
  }

  Future<void> getUsers() async {
    users = await chatsRepo.getAllUsers();
    emit(GetAllUsersState());
  }
  void updateGroupMembers(UserModel user,bool isInGroup) async {
    if(!isInGroup){
      groupMembers.add(user);
    }else{
      groupMembers.remove(user);
    }
    emit(UpdateGroupMembersState());
  }
}
