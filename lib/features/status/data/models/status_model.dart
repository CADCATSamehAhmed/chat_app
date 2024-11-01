class StatusModel {
  late dynamic media;
  late dynamic mediaDescription;
  late dynamic text;
  late dynamic textBGColorIndex;
  late int statusPlayTime;
  late dynamic timestamp;
  // late List<dynamic>? watchersIds;

  StatusModel(
    this.media,
    this.mediaDescription,
    this.text,
    this.textBGColorIndex,
    this.statusPlayTime,
    this.timestamp,
    // this.watchersIds,
  );

  StatusModel.fromJson(Map<String, dynamic>? json, {data}) {
    timestamp = json!['timestamp'];
    media = json['media'];
    mediaDescription = json['mediaDescription'];
    text = json['text'];
    textBGColorIndex = json['textBGColorIndex'];
    statusPlayTime = json['statusPlayTime'];
    // watchersIds = json['watchersIds'];
  }

  Map<String, dynamic> toMap() {
    return {
      'media': media,
      'mediaDescription': mediaDescription,
      'text': text,
      'textBGColorIndex': textBGColorIndex,
      'statusPlayTime': statusPlayTime,
      'timestamp': timestamp,
      // 'watchersIds': watchersIds,
    };
  }
}

