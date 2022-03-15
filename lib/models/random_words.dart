// To parse this JSON data, do
//
//     final randomWordModel = randomWordModelFromJson(jsonString);

import 'dart:convert';

List<RandomWordModel> randomWordModelFromJson(String str) => List<RandomWordModel>.from(json.decode(str).map((x) => RandomWordModel.fromJson(x)));

String randomWordModelToJson(List<RandomWordModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandomWordModel {
    RandomWordModel({
        this.id,
        this.word,
    });

    int? id;
    String? word;

    factory RandomWordModel.fromJson(Map<String, dynamic> json) => RandomWordModel(
        id: json["id"] == null ? null : json["id"],
        word: json["word"] == null ? null : json["word"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "word": word == null ? null : word,
    };
}
