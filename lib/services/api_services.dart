import 'package:dictionary_app/models/search_word_model.dart';
import 'package:dictionary_app/models/word_audio_model.dart';
import 'package:dictionary_app/services/api_string_keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/day_word_model.dart';

class ApiServices {
  // ApiKeysConst apiKeysConst = ApiKeysConst();
  static const String baseUrl = "https://api.wordnik.com/";
  static const String apiKey =
      "a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5";

  Future<DayWord> getDayWord() async {
    DayWord? _dayWord;

    var url = Uri.parse(
        "$baseUrl${ApiKeysConst.wordOfTheDayApiString}api_key=${apiKey}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      _dayWord = DayWord.fromJson(jsonResponse);
    } else {
      print(response.statusCode);
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
    return Future.value(_dayWord);
  }

  Future<SearchWordsModel> getSearchWord() async {
    SearchWordsModel? _searchWordsModel;

    var url = Uri.parse(
        "https://api.wordnik.com/v4/words.json/randomWords?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1&limit=500&api_key=q095std75p9uysknwxmaxeyw0zqzsaa0spj8jln0rm9tiv653");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      _searchWordsModel = SearchWordsModel.fromJson(jsonResponse);
    } else {
      print(response.statusCode);
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
    return Future.value(_searchWordsModel);
  }

  Future<WordAudioModel> getWordSound(String myword) async {
    WordAudioModel? _wordAudioModel;

    var url = Uri.parse(baseUrl +
        ApiKeysConst.getAudioWord(
          word: myword,
        ));

    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      _wordAudioModel = WordAudioModel.fromJson(jsonResponse[0]);
    } else {
      print(response.statusCode);
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
    return Future.value(_wordAudioModel);
  }
}
