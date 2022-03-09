class ApiKeysConst {
  static const String wordOfTheDayApiString = 'v4/words.json/wordOfTheDay?';

  static String getAudioWord({required String word}) =>
      "v4/word.json/$word/audio?useCanonical=false&limit=50&api_key=q095std75p9uysknwxmaxeyw0zqzsaa0spj8jln0rm9tiv653";
}
