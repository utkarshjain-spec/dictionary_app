// To parse this JSON data, do
//
//     final dayWord = dayWordFromJson(jsonString);

import 'dart:convert';

DayWord dayWordFromJson(String str) => DayWord.fromJson(json.decode(str));

String dayWordToJson(DayWord data) => json.encode(data.toJson());

class DayWord {
    DayWord({
        this.id,
        this.word,
        this.contentProvider,
        this.definitions,
        this.publishDate,
        this.examples,
        this.pdd,
        this.htmlExtra,
        this.note,
    });

    String ?id;
    String? word;
    ContentProvider? contentProvider;
    List<Definition>? definitions;
    DateTime? publishDate;
    List<Example>? examples;
    DateTime? pdd;
    dynamic htmlExtra;
    String? note;

    factory DayWord.fromJson(Map<String, dynamic> json) => DayWord(
        id: json["_id"] == null ? null : json["_id"],
        word: json["word"] == null ? null : json["word"],
        contentProvider: json["contentProvider"] == null ? null : ContentProvider.fromJson(json["contentProvider"]),
        definitions: json["definitions"] == null ? null : List<Definition>.from(json["definitions"].map((x) => Definition.fromJson(x))),
        publishDate: json["publishDate"] == null ? null : DateTime.parse(json["publishDate"]),
        examples: json["examples"] == null ? null : List<Example>.from(json["examples"].map((x) => Example.fromJson(x))),
        pdd: json["pdd"] == null ? null : DateTime.parse(json["pdd"]),
        htmlExtra: json["htmlExtra"],
        note: json["note"] == null ? null : json["note"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "word": word == null ? null : word,
        "contentProvider": contentProvider == null ? null : contentProvider!.toJson(),
        "definitions": definitions == null ? null : List<dynamic>.from(definitions!.map((x) => x.toJson())),
        "publishDate": publishDate == null ? null : publishDate!.toIso8601String(),
        "examples": examples == null ? null : List<dynamic>.from(examples!.map((x) => x.toJson())),
        "pdd": pdd == null ? null : "${pdd!.year.toString().padLeft(4, '0')}-${pdd!.month.toString().padLeft(2, '0')}-${pdd!.day.toString().padLeft(2, '0')}",
        "htmlExtra": htmlExtra,
        "note": note == null ? null : note,
    };
}

class ContentProvider {
    ContentProvider({
        this.name,
        this.id,
    });

    String? name;
    int? id;

    factory ContentProvider.fromJson(Map<String, dynamic> json) => ContentProvider(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
    };
}

class Definition {
    Definition({
        this.source,
        this.text,
        this.note,
        this.partOfSpeech,
    });

    String? source;
    String? text;
    dynamic note;
    String? partOfSpeech;

    factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        source: json["source"] == null ? null : json["source"],
        text: json["text"] == null ? null : json["text"],
        note: json["note"],
        partOfSpeech: json["partOfSpeech"] == null ? null : json["partOfSpeech"],
    );

    Map<String, dynamic> toJson() => {
        "source": source == null ? null : source,
        "text": text == null ? null : text,
        "note": note,
        "partOfSpeech": partOfSpeech == null ? null : partOfSpeech,
    };
}

class Example {
    Example({
        this.url,
        this.title,
        this.text,
        this.id,
    });

    String? url;
    String? title;
    String? text;
    int? id;

    factory Example.fromJson(Map<String, dynamic> json) => Example(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "text": text == null ? null : text,
        "id": id == null ? null : id,
    };
}
