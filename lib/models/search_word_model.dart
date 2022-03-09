// To parse this JSON data, do
//
//     final searchWordsModel = searchWordsModelFromJson(jsonString);

import 'dart:convert';

List<SearchWordsModel> searchWordsModelFromJson(String str) =>
    List<SearchWordsModel>.from(
        json.decode(str).map((x) => SearchWordsModel.fromJson(x)));

String searchWordsModelToJson(List<SearchWordsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchWordsModel {
  SearchWordsModel({
    this.id,
    this.word,
  });

  int? id;
  String? word;

  factory SearchWordsModel.fromJson(Map<String, dynamic> json) =>
      SearchWordsModel(
        id: json["id"] == null ? null : json["id"],
        word: json["word"] == null ? null : json["word"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "word": word == null ? null : word,
      };
}
