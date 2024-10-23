class MessageModel {
  late String senderId;
  late String message;
  late dynamic timestamp;
  late String date;

  MessageModel(this.senderId, this.message, this.timestamp, this.date);

  MessageModel.fromJson(Map<String, dynamic>? json, {data}) {
    senderId = json!['senderId'];
    timestamp = json['timestamp'];
    message = json['message'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
      'date': date,
    };
  }
}
