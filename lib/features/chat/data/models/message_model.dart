class MessageModel {
  late String senderId;
  late String message;
  late dynamic timestamp;

  MessageModel({required this.senderId, required this.message,required this.timestamp});

  MessageModel.fromJson(Map<String, dynamic>? json, {data}) {
    senderId = json!['senderId'];
    timestamp = json['timestamp'];
    message = json['message'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
