class GroupModel {
  late String chatId;
  late String name;
  late List<dynamic> participantsIds;
  late String image;
  late String lastMessage;
  late String lastMessageDate;
  late int newMessagesNumber;
  late dynamic timestamp;

  GroupModel(
      this.chatId,
      this.name,
      this.image,
      this.participantsIds,
      this.lastMessage,
      this.lastMessageDate,
      this.newMessagesNumber,
      this.timestamp,
      );

  GroupModel.fromJson(Map<String, dynamic>? json, {data}) {
    chatId = json!['chatId'];
    name = json['name'];
    image = json['image'];
    participantsIds = json['participantsIds'];
    lastMessage = json['lastMessage'];
    lastMessageDate = json['lastMessageDate'];
    newMessagesNumber = json['newMessagesNumber'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'name': name,
      'image': image,
      'participantsIds': participantsIds,
      'lastMessage': lastMessage,
      'lastMessageDate': lastMessageDate,
      'newMessagesNumber': newMessagesNumber,
      'timestamp': timestamp,
    };
  }
}
