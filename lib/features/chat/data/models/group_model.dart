import 'package:chat_app/features/chat/data/models/message_model.dart';

class GroupModel {
  late String groupId;
  late List<dynamic> groupPartnerIds;
  late String groupAdminId;
  late int newMessagesNumber;
  late dynamic timestamp;
  late String groupName;
  late String groupImage;
  late MessageModel? lastMessage;

  GroupModel(
      this.groupId,
      this.groupPartnerIds,
      this.groupAdminId,
      this.newMessagesNumber,
      this.timestamp,
      this.groupName,
      this.groupImage, {
      this.lastMessage,
      });

  GroupModel.fromJson(
      Map<String, dynamic>? json,
      MessageModel? groupLastMessage,
      ) {
    groupId = json!['groupId'];
    groupPartnerIds = json['groupPartnerIds'];
    groupAdminId = json['groupAdminId'];
    timestamp = json['timestamp'];
    newMessagesNumber = json['newMessagesNumber'];
    groupName=json['groupName'];
    groupImage=json['groupImage'];
    lastMessage=groupLastMessage;
  }

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'groupPartnerIds': groupPartnerIds,
      'groupAdminId': groupAdminId,
      'groupName': groupName,
      'groupImage': groupImage,
      'timestamp': timestamp,
      'newMessagesNumber': newMessagesNumber,
    };
  }
}
