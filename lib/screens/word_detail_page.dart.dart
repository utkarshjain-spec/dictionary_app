import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dictionary_app/constants.dart';
import 'package:dictionary_app/local_data_saver.dart';
import 'package:dictionary_app/states/day_word_state.dart';

class DetailPage extends StatefulWidget {
  String dailyWord;
  DetailPage({
    Key? key,
    required this.dailyWord,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String>? _words;
  List<String>? _historyWords = [];
  bool isSelected = false;
  // List<String> _words = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? word;
  String? Definition;
  late DateTime _dateTime;
  String? date;
  bool isUserLoggedIn = false;
  Future<bool?> checkUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    if (user != null) {
      isUserLoggedIn = true;
      setState(() {});
    } else {
      isUserLoggedIn = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        _words = value;
        setState(() {});
      });
    });

    checkUser();

    LocalDataSaver.getHistory().then((value) {
      setState(() {
        if (value != null) {
          _historyWords = value;
        }
      });
    }).then((value) {
      if (widget.dailyWord != null) {
        if (!_historyWords!.contains(widget.dailyWord)) {
          // _historyWords!.remove(word ?? "");

          _historyWords!.add(widget.dailyWord);

          LocalDataSaver.setHistory(_historyWords!);
        }
      }
    });
    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        _words = value;
        SavedWords.savedWords = value!;
        setState(() {});
      });
    });

    _dateTime = DateTime.now();
    date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();

    var wordState = Provider.of<WordState>(context, listen: false);
    wordState.getDayWord(date).then((value) {
      setState(() {
        word = wordState.dayWord?.word;
        Definition = wordState.dayWord?.definitions?[0].text;
      });
    }).then((value) {
      // SavedWords.history.add(word ?? "");
      // LocalDataSaver.setHistory(SavedWords.history);
    });

    _prefs.then((prefs) {
      isSelected = prefs.getBool('isSelected')!;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        _words = value;
        setState(() {});
      });
    });
    bool alreadySaved = _words?.contains(word) ?? false;
    // setState(() {});
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Word Detail Page'),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(
                    "word: ${word.toString()} \n Definition: ${Definition.toString()}");
              },
              icon: Icon(Icons.share)),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<WordState>(
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 190, 111, 20),
                              child: Text("W",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(width: 16),
                            Text(
                              value.dayWord?.word ?? "",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  flutterTts.speak(value.dayWord?.word ?? "");
                                  // for (int i = 0;
                                  //     i < value.dayWord!.definitions!.length;
                                  //     i++) {
                                  //   Future.delayed(Duration(seconds: 3), () {
                                  //     flutterTts.speak(
                                  //         value.dayWord?.definitions?[i].text ??
                                  //             "");
                                  //   });
                                  // }
                                  // for (int i = 0;
                                  //     i < value.dayWord!.examples!.length;
                                  //     i++) {
                                  //   Future.delayed(Duration(seconds: 5), () {
                                  //     flutterTts.speak(
                                  //         value.dayWord?.examples?[i].text ??
                                  //             "");
                                  //   });
                                  // }
                                },
                                icon: Icon(Icons.volume_up)),
                            isUserLoggedIn
                                ? IconButton(
                                    onPressed: () {
                                      LocalDataSaver.getSaveWord()
                                          .then((value) {
                                        setState(() {
                                          _words = value;
                                          if (_words != null && word != null) {
                                            if (_words!.contains(word)) {
                                              _words!.remove(word);
                                              LocalDataSaver.setSaveWord(
                                                  _words!);
                                            } else {
                                              _words!.add(word!);
                                              LocalDataSaver.setSaveWord(
                                                  _words!);
                                            }
                                          }

                                          SavedWords.savedWords = value!;
                                          setState(() {});
                                        });
                                      });

                                      LocalDataSaver.setSaveWord(
                                          SavedWords.savedWords);
                                      setState(() {});
                                      // } else {

                                      // }
                                    },
                                    icon: alreadySaved != null
                                        ? alreadySaved
                                            ? Icon(
                                                Icons.favorite,
                                                color: alreadySaved
                                                    ? Colors.red
                                                    : Colors.black,
                                              )
                                            : Icon(Icons.favorite_border)
                                        : Text("data"),
                                  )
                                : Text("")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Definations',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          itemCount: value.dayWord?.definitions?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value.dayWord?.definitions?[index].text ??
                                    ""),
                                SizedBox(height: 10),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Examples',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          itemBuilder: ((context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    value.dayWord?.examples?[index].text ?? ""),
                                SizedBox(height: 10),
                              ],
                            );
                          }),
                          itemCount: value.dayWord?.examples?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
