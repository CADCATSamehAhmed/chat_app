import 'status_model.dart';

class StatusesModel {
  final List<StatusModel> statuses;
  final String uId;
  final String image;
  final String name;

  StatusesModel({
    required this.statuses,
    required this.uId,
    required this.image,
    required this.name,
  });

  factory StatusesModel.fromUserJson(Map<String, dynamic> json, List<StatusModel> statuses) {
    return StatusesModel(
      statuses: statuses,
      uId: json['uid'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statuses': statuses.map((status) => status.toMap()).toList(),
      'uId': uId,
      'image': image,
      'name': name,
    };
  }
}