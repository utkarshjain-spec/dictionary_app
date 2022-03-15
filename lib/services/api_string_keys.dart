class ApiKeysConst {
  static String getWordOfTheDay({String? date}) =>
      'v4/words.json/wordOfTheDay?date=$date&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5';

  static String getSearchWordApiKey =
      "https://api.wordnik.com/v4/words.json/randomWords?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1&limit=500&api_key=q095std75p9uysknwxmaxeyw0zqzsaa0spj8jln0rm9tiv653";

  static String getAudioWord({required String word}) =>
      "v4/word.json/$word/audio?useCanonical=false&limit=50&api_key=q095std75p9uysknwxmaxeyw0zqzsaa0spj8jln0rm9tiv653";

  static const String RandomWordApiString =
      'v4/words.json/randomWords?hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1&limit=10&';

  static String getWordDefinition({required String word}) =>
      "https://api.wordnik.com/v4/word.json/$word/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=q095std75p9uysknwxmaxeyw0zqzsaa0spj8jln0rm9tiv653";

  static String getWordExample({required String word}) =>
      "https://api.wordnik.com/v4/word.json/$word/examples?limit=50&includeDuplicates=false&useCanonical=false&skip=0&api_key=q095std75p9uysknwxmaxeyw0zqzsaa0spj8jln0rm9tiv653";
}
