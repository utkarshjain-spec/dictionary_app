import 'package:dictionary_app/models/search_word_model.dart';
import 'package:dictionary_app/models/word_audio_model.dart';
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

  Future<bool> getDayWord() async {
    await _apiServices.getDayWord().then((value) {
      dayWord = value;
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
      return value;
    });
  }
}
