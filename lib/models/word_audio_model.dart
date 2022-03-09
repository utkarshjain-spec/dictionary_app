// To parse this JSON data, do
//
//     final wordAudioModel = wordAudioModelFromJson(jsonString);

import 'dart:convert';

List<WordAudioModel> wordAudioModelFromJson(String str) =>
    List<WordAudioModel>.from(
        json.decode(str).map((x) => WordAudioModel.fromJson(x)));

String wordAudioModelToJson(List<WordAudioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WordAudioModel {
  WordAudioModel({
    this.commentCount,
    this.createdBy,
    this.createdAt,
    this.id,
    this.word,
    this.duration,
    this.audioType,
    this.attributionText,
    this.attributionUrl,
    this.fileUrl,
    this.description,
  });

  int? commentCount;
  String? createdBy;
  String? createdAt;
  int? id;
  String? word;
  double? duration;
  String? audioType;
  String? attributionText;
  String? attributionUrl;
  String? fileUrl;
  String? description;

  factory WordAudioModel.fromJson(Map<String, dynamic> json) => WordAudioModel(
        commentCount:
            json["commentCount"] == null ? null : json["commentCount"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: json["id"] == null ? null : json["id"],
        word: json["word"] == null ? null : json["word"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        audioType: json["audioType"] == null ? null : json["audioType"],
        attributionText:
            json["attributionText"] == null ? null : json["attributionText"],
        attributionUrl:
            json["attributionUrl"] == null ? null : json["attributionUrl"],
        fileUrl: json["fileUrl"] == null ? null : json["fileUrl"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "commentCount": commentCount == null ? null : commentCount,
        "createdBy": createdBy == null ? null : createdBy,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
        "word": word == null ? null : word,
        "duration": duration == null ? null : duration,
        "audioType": audioType == null ? null : audioType,
        "attributionText": attributionText == null ? null : attributionText,
        "attributionUrl": attributionUrl == null ? null : attributionUrl,
        "fileUrl": fileUrl == null ? null : fileUrl,
        "description": description == null ? null : description,
      };
}
