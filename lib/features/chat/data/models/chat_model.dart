class ChatModel {
  late String chatId;
  late String chatPartnerId;
  late int newMessagesNumber;
  late dynamic timestamp;
  late String name;
  late String image;
  late String? lastMessage;
  late String? lastMessageDate;

  ChatModel(
    this.chatId,
    this.chatPartnerId,
    this.newMessagesNumber,
    this.timestamp,
    this.name,
    this.image, {
    this.lastMessage,
    this.lastMessageDate,
  });

  ChatModel.fromJson(
    Map<String, dynamic>? json,
    String userName,
    String userImage,
    String? chatLastMessage,
    String? chatLastMessageDate,
  ) {
    chatId = json!['chatId'];
    chatPartnerId = json['chatPartnerId'];
    timestamp = json['timestamp'];
    newMessagesNumber = json['newMessagesNumber'];
    name=userName;
    image=userImage;
    lastMessage=chatLastMessage;
    lastMessageDate=chatLastMessageDate;
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'chatPartnerId': chatPartnerId,
      'timestamp': timestamp,
      'newMessagesNumber': newMessagesNumber,
    };
  }
}
