import 'dart:convert';

List<DefinitionModel> randomWordModelFromJson(String str) =>
    List<DefinitionModel>.from(
        json.decode(str).map((x) => DefinitionModel.fromJson(x)));

String randomWordModelToJson(List<DefinitionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DefinitionModel {
  DefinitionModel({
    this.id,
    this.partOfSpeech,
    this.attributionText,
    this.sourceDictionary,
    this.text,
    this.sequence,
    this.score,
    this.labels,
    this.citations,
    this.word,
    this.relatedWords,
    this.exampleUses,
    this.textProns,
    this.notes,
    this.attributionUrl,
    this.wordnikUrl,
  });

  String? id;
  String? partOfSpeech;
  String? attributionText;
  String? sourceDictionary;
  String? text;
  String? sequence;
  int? score;
  List<dynamic>? labels;
  List<dynamic>? citations;
  String? word;
  List<dynamic>? relatedWords;
  List<Exampleus>? exampleUses;
  List<dynamic>? textProns;
  List<dynamic>? notes;
  String? attributionUrl;
  String? wordnikUrl;

  factory DefinitionModel.fromJson(Map<String, dynamic> json) =>
      DefinitionModel(
        id: json["id"] == null ? null : json["id"],
        partOfSpeech:
            json["partOfSpeech"] == null ? null : json["partOfSpeech"],
        attributionText:
            json["attributionText"] == null ? null : json["attributionText"],
        sourceDictionary:
            json["sourceDictionary"] == null ? null : json["sourceDictionary"],
        text: json["text"] == null ? null : json["text"],
        sequence: json["sequence"] == null ? null : json["sequence"],
        score: json["score"] == null ? null : json["score"],
        labels: json["labels"] == null
            ? null
            : List<dynamic>.from(json["labels"].map((x) => x)),
        citations: json["citations"] == null
            ? null
            : List<dynamic>.from(json["citations"].map((x) => x)),
        word: json["word"] == null ? null : json["word"],
        relatedWords: json["relatedWords"] == null
            ? null
            : List<dynamic>.from(json["relatedWords"].map((x) => x)),
        exampleUses: json["exampleUses"] == null
            ? null
            : List<Exampleus>.from(
                json["exampleUses"].map((x) => Exampleus.fromJson(x))),
        textProns: json["textProns"] == null
            ? null
            : List<dynamic>.from(json["textProns"].map((x) => x)),
        notes: json["notes"] == null
            ? null
            : List<dynamic>.from(json["notes"].map((x) => x)),
        attributionUrl:
            json["attributionUrl"] == null ? null : json["attributionUrl"],
        wordnikUrl: json["wordnikUrl"] == null ? null : json["wordnikUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "partOfSpeech": partOfSpeech == null ? null : partOfSpeech,
        "attributionText": attributionText == null ? null : attributionText,
        "sourceDictionary": sourceDictionary == null ? null : sourceDictionary,
        "text": text == null ? null : text,
        "sequence": sequence == null ? null : sequence,
        "score": score == null ? null : score,
        "labels":
            labels == null ? null : List<dynamic>.from(labels!.map((x) => x)),
        "citations": citations == null
            ? null
            : List<dynamic>.from(citations!.map((x) => x)),
        "word": word == null ? null : word,
        "relatedWords": relatedWords == null
            ? null
            : List<dynamic>.from(relatedWords!.map((x) => x)),
        "exampleUses": exampleUses == null
            ? null
            : List<dynamic>.from(exampleUses!.map((x) => x.toJson())),
        "textProns": textProns == null
            ? null
            : List<dynamic>.from(textProns!.map((x) => x)),
        "notes":
            notes == null ? null : List<dynamic>.from(notes!.map((x) => x)),
        "attributionUrl": attributionUrl == null ? null : attributionUrl,
        "wordnikUrl": wordnikUrl == null ? null : wordnikUrl,
      };
}

class Exampleus {
  Exampleus({
    this.text,
  });

  String? text;

  factory Exampleus.fromJson(Map<String, dynamic> json) => Exampleus(
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
      };
}
