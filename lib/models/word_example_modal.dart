// To parse this JSON data, do
//
//     final wordExampleModal = wordExampleModalFromJson(jsonString);

import 'dart:convert';

WordExampleModal wordExampleModalFromJson(String str) =>
    WordExampleModal.fromJson(json.decode(str));

String wordExampleModalToJson(WordExampleModal data) =>
    json.encode(data.toJson());

class WordExampleModal {
  WordExampleModal({
    this.examples,
  });

  List<Example>? examples;

  factory WordExampleModal.fromJson(Map<String, dynamic> json) =>
      WordExampleModal(
        examples: json["examples"] == null
            ? null
            : List<Example>.from(
                json["examples"].map((x) => Example.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "examples": examples == null
            ? null
            : List<dynamic>.from(examples!.map((x) => x.toJson())),
      };
}

class Example {
  Example({
    this.Wordprovider,
    this.year,
    this.rating,
    this.url,
    this.word,
    this.text,
    this.documentId,
    this.exampleId,
    this.title,
    this.author,
  });

  WordProvider? Wordprovider;
  int? year;
  double? rating;
  String? url;
  String? word;
  String? text;
  int? documentId;
  int? exampleId;
  String? title;
  String? author;

  factory Example.fromJson(Map<String, dynamic> json) => Example(
        Wordprovider: json["provider"] == null
            ? null
            : WordProvider.fromJson(json["provider"]),
        year: json["year"] == null ? null : json["year"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        url: json["url"] == null ? null : json["url"],
        word: json["word"] == null ? null : json["word"],
        text: json["text"] == null ? null : json["text"],
        documentId: json["documentId"] == null ? null : json["documentId"],
        exampleId: json["exampleId"] == null ? null : json["exampleId"],
        title: json["title"] == null ? null : json["title"],
        author: json["author"] == null ? null : json["author"],
      );

  Map<String, dynamic> toJson() => {
        "provider": Wordprovider == null ? null : Wordprovider!.toJson(),
        "year": year == null ? null : year,
        "rating": rating == null ? null : rating,
        "url": url == null ? null : url,
        "word": word == null ? null : word,
        "text": text == null ? null : text,
        "documentId": documentId == null ? null : documentId,
        "exampleId": exampleId == null ? null : exampleId,
        "title": title == null ? null : title,
        "author": author == null ? null : author,
      };
}

class WordProvider {
  WordProvider({
    this.id,
  });

  int? id;

  factory WordProvider.fromJson(Map<String, dynamic> json) => WordProvider(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
      };
}
