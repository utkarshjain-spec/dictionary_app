import 'package:dictionary_app/models/definition_modal.dart';
import 'package:dictionary_app/models/random_words.dart';
import 'package:dictionary_app/models/search_word_model.dart';
import 'package:dictionary_app/models/word_audio_model.dart';
import 'package:dictionary_app/models/word_example_modal.dart';
import 'package:dictionary_app/services/api_services.dart';
import 'package:flutter/material.dart';

import '../models/day_word_model.dart';

class WordState extends ChangeNotifier {
  ApiServices _apiServices = ApiServices();
  DayWord? _dayWord;
  DayWord? get dayWord => _dayWord;
  set dayWord(DayWord? value) {
    _dayWord = value;
    notifyListeners();
  }

  DayWord? _dayWord1;
  DayWord? get dayWord1 => _dayWord1;
  set dayWord1(DayWord? value) {
    _dayWord1 = value;
    notifyListeners();
  }

  SearchWordsModel? _searchWordsModel;
  SearchWordsModel? get searchWordsModel => _searchWordsModel;
  set searchWordsModel(SearchWordsModel? value) {
    _searchWordsModel = value;
    notifyListeners();
  }

  WordAudioModel? _wordAudioModel;
  WordAudioModel? get wordAudioModel => _wordAudioModel;
  set wordAudioModel(WordAudioModel? value) {
    _wordAudioModel = value;
    notifyListeners();
  }

  Future<bool> getDayWord(String? date) async {
    await _apiServices.getDayWord(date).then((value) {
      dayWord = value;
    });
    return true;
  }

  Future<bool> getSelectedDateWOrd(String? date) async {
    await _apiServices.getSelectedDateWOrd(date).then((value) {
      dayWord1 = value;
    });
    return true;
  }

  Future<SearchWordsModel> getSearchWord() async {
    return _apiServices.getSearchWord().then((value) {
      searchWordsModel = value;
      return value;
    });
  }

  Future<WordAudioModel> getWordSound(String word) async {
    return _apiServices.getWordSound(word).then((value) {
      wordAudioModel = value;
      return value!;
    });
  }

  Future<List<RandomWordModel>> getRandomWord() async {
    return _apiServices.getRandomWord().then((value) {
      return value ?? [];
    });
  }

  Future<List<DefinitionModel>?> getWordDefinitions(String word) async {
    return _apiServices.getWordDefinitions(word).then((value) {
      if (value != null) {
        return value;
      } else {
        return null;
      }
    });
  }

  Future<WordExampleModal?> getWordExamples(String word) async {
    return _apiServices.getWordExamples(word).then((value) {
      if (value != null) {
        return value;
      } else {
        return null;
      }
    });
  }
}
