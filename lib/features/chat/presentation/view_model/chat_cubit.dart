import 'dart:io';
import 'package:chat_app/core/constants/variables.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/chat/data/models/group_message_model.dart';
import 'package:chat_app/features/chat/data/models/group_model.dart';
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
class StartNewChatState extends ChatStates {}
class SendNewMessageState extends ChatStates {}
class CloseChatState extends ChatStates {}
class PickMediaSuccessState extends ChatStates {}
class PickMediaErrorState extends ChatStates {}
class GetAllUsersLoadingState extends ChatStates {}
class GetAllUsersSuccessState extends ChatStates {}
class DeleteChatState extends ChatStates {}
class ClearChatState extends ChatStates {}
class UpdateGroupMembersState extends ChatStates {}

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit? _chatCubit;
  ChatsRepo chatsRepo = ChatsRepo();
  List<ChatModel> chats = [];
  List<GroupModel> groups = [];
  List<UserModel> users = [];
  List<UserModel> groupMembers = [];
  List<MessageModel> messages = [];
  List<GroupMessageModel> groupMessages = [];

  static ChatCubit get(context) {
    _chatCubit ??= BlocProvider.of(context);
    return _chatCubit!;
  }

  Stream<List<ChatModel>> getChatsNew() {
    chats = [];
    return chatsRepo.getChatsNew().map((chatList) {
      chats = chatList;
      return chatList;
    });
  }

  Stream<List<GroupModel>> getGroups() {
    groups = [];
    return chatsRepo.getGroups().map((groupsList) {
      groups = groupsList;
      return groupsList;
    });
  }

  void startNewChat(UserModel userData) {
    bool startNewChat = true;
    for (var chat in chats) {
      if (chat.chatPartnerId == userData.uid) {
        startNewChat = false;
        get_x.Get.off(() => InsideChatView(chat: chat,),
            transition: get_x.Transition.leftToRight);
        continue;
      }
    }
    if (startNewChat) {
      chatsRepo.startNewChat(userData);
    }
    emit(StartNewChatState());
  }

  void startNewGroup(String groupName) {
    List<String> partnersIds = [];
    partnersIds.add(uid!);
    for (var member in groupMembers) {
      partnersIds.add(member.uid);
    }
    chatsRepo.startNewGroup(groupName, file!, partnersIds);
    emit(StartNewChatState());
  }

  void getChatMessages(QuerySnapshot<Object?>? data) {
    messages = [];
    messages = chatsRepo.getMessages(data);
  }

  void getGroupMessages(QuerySnapshot<Object?>? data) {
    groupMessages = [];
    groupMessages = chatsRepo.getGroupMessages(data);
  }

  void sendMessage(bool isGroup, ChatModel? chat, GroupModel? group, TextEditingController controller, ScrollController scrollController,String? senderName,String? senderImage) {
    if (isGroup) {
      chatsRepo.sendGroupMessage(group!.groupId, group.groupPartnerIds,GroupMessageModel(
          senderId: uid!,
          message: controller.text,
          timestamp: FieldValue.serverTimestamp(),
          senderName: senderName!,
          senderImage: senderImage!));
    } else {
      chatsRepo.sendMessage(
          chat!.chatId,
          chat.chatPartnerId,
          MessageModel(
              senderId: uid!,
              message: controller.text,
              timestamp: FieldValue.serverTimestamp(),
              ));
    }
    controller.clear();
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

  void closeChat(bool isGroup,String chatId) async {
    await chatsRepo.updateChat(isGroup,chatId);
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
    emit(GetAllUsersLoadingState());
    users =[];
    users = await chatsRepo.getAllUsers();
    emit(GetAllUsersSuccessState());
  }

  Future<void> deleteChat(ChatModel chat) async {
    await chatsRepo.deleteChat(chat);
    emit(DeleteChatState());
  }
  Future<void> clearChat(String id) async {
    await chatsRepo.clearChat(id);
    emit(ClearChatState());
  }

  void updateGroupMembers(UserModel user, bool isInGroup) async {
    if (!isInGroup) {
      groupMembers.add(user);
    } else {
      groupMembers.remove(user);
    }
    emit(UpdateGroupMembersState());
  }
}
