import 'package:dictionary_app/models/definition_modal.dart';
import 'package:dictionary_app/models/random_words.dart';
import 'package:dictionary_app/models/search_word_model.dart';
import 'package:dictionary_app/models/word_audio_model.dart';
import 'package:dictionary_app/models/word_example_modal.dart';
import 'package:dictionary_app/services/api_string_keys.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/day_word_model.dart';

class ApiServices {
  // ApiKeysConst apiKeysConst = ApiKeysConst();
  static const String baseUrl = "https://api.wordnik.com/";
  static const String apiKey =
      "a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5";

  Future<DayWord?> getDayWord(String? date) async {
    DayWord? _dayWord;

    var url = Uri.parse(baseUrl + ApiKeysConst.getWordOfTheDay(date: date));
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        _dayWord = DayWord.fromJson(jsonResponse);
        return _dayWord;
      } else {
        print(response.statusCode);
        throw Exception('Data not found');
      }
    } catch (e) {
      return null;
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
  }

  Future<DayWord?> getSelectedDateWOrd(String? date) async {
    DayWord? _dayWord;

    var url = Uri.parse(baseUrl + ApiKeysConst.getWordOfTheDay(date: date));
    var response = await http.get(url);
   
    try {
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        _dayWord = DayWord.fromJson(jsonResponse);
        return _dayWord;
      } else {
        print(response.statusCode);
        throw Exception('Failed to load post');
      }
    } catch (e) {
      return null;
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
  }

  Future<SearchWordsModel> getSearchWord() async {
    SearchWordsModel? _searchWordsModel;

    var url = Uri.parse(ApiKeysConst.getSearchWordApiKey);

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

  Future<WordAudioModel?> getWordSound(String myword) async {
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
    throw Exception('Failed to load word sound');
  }

  Future<List<DefinitionModel>?> getWordDefinitions(String myword) async {
    List<DefinitionModel>? _definitionModel;

    var url = Uri.parse(ApiKeysConst.getWordDefinition(
      word: myword,
    ));

    try {
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        // var jsonResponse = json.decode(response.body);
        // _definitionModel = DefinitionModel.fromJson(jsonResponse);
        _definitionModel = (json.decode(response.body) as List)
            .map((i) => DefinitionModel.fromJson(i))
            .toList();

        return Future.value(_definitionModel);
      } else {
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      return null;
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
  }

  Future<WordExampleModal?> getWordExamples(String myword) async {
    WordExampleModal? _wordExampleModal;

    var url = Uri.parse(ApiKeysConst.getWordExample(
      word: myword,
    ));

    var response = await http.get(
      url,
    );
    try {
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        _wordExampleModal = WordExampleModal.fromJson(jsonResponse);

        // _wordExampleModal = (json.decode(response.body) as List)

        //     .map((i) => WordExampleModal.fromJson(i))
        //     .toList();
        return Future.value(_wordExampleModal);
      } else if (response.statusCode == 404) {
        print("Not Found");
      } else if (response.statusCode == 500) {
        print("server not responding");
      } else {
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      return null;
    }
    // var jsonResponse = json.decode(response.body);
    // DayWord _dayword = DayWord.fromJson(jsonResponse);
  }

  Future<List<RandomWordModel>?> getRandomWord() async {
    List<RandomWordModel>? _randomWordModel;

    var url = Uri.parse(
        "$baseUrl${ApiKeysConst.RandomWordApiString}api_key=${apiKey}");
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        _randomWordModel = (jsonResponse as List)
            .map((i) => RandomWordModel.fromJson(i))
            .toList();
        return Future.value(_randomWordModel);
      } else {
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      return null;

      // print(e);
    }
  }
}
