import 'message_model.dart';

class GroupMessageModel extends MessageModel {
  final String senderName;
  final String senderImage;

  GroupMessageModel({
    required super.senderId,
    required super.message,
    required super.timestamp,
    required this.senderName,
    required this.senderImage,
  });

  // fromJson constructor with additional fields
  GroupMessageModel.fromJson(Map<String, dynamic> json)
      : senderName = json['senderName'] ?? '',
        senderImage = json['senderImage'] ?? '',
        super.fromJson(json);

  // Override toMap to add extra fields
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'senderName': senderName,
      'senderImage': senderImage,
    });
    return map;
  }
}