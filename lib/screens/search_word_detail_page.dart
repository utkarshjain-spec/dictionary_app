import 'package:dictionary_app/constants.dart';

import 'package:dictionary_app/models/definition_modal.dart';

import 'package:dictionary_app/models/word_example_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';
import '../local_data_saver.dart';
import '../states/day_word_state.dart';

class SearchWordDetailPage extends StatefulWidget {
  String? word;
  List<DefinitionModel>? definition;
  WordExampleModal? example;

  SearchWordDetailPage({
    Key? key,
    this.word,
  }) : super(key: key);

  @override
  State<SearchWordDetailPage> createState() => _SearchWordDetailPageState();
}

class _SearchWordDetailPageState extends State<SearchWordDetailPage> {
  List<String>? _words;
  List<String>? _historyWords = [];
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

  // @override
  // void dispose() {
  //   // TtsState ttsState = TtsState.stopped;
  //   _stop();
  //   super.dispose();
  // }

  // Future _stop() async {
  //   await flutterTts.stop();
  // }

  @override
  void initState() {
    checkUser();

    LocalDataSaver.getHistory().then((value) {
      setState(() {
        if (value != null) {
          _historyWords = value;
        } else {
          _historyWords = [];
        }

        // SavedWords.history = value!;
      });
    }).then((value) {
      if (widget.word != null) {
        // SavedWords.history.add(widget.word ?? "");

        if (_historyWords?.contains(widget.word) == false) {
          _historyWords?.add(widget.word!);
          LocalDataSaver.setHistory(_historyWords!);
        }
      }
    });

    // if(widget.word != null) {

    //    SavedWords.history.add(widget.word??"");

    // }

    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        _words = value;
        setState(() {});
      });
    });

    Provider.of<WordState>(context, listen: false)
        .getWordExamples(widget.word ?? "")
        .then((value) {
      widget.example = value;
      setState(() {});
    });
    Provider.of<WordState>(context, listen: false)
        .getWordDefinitions(widget.word ?? "")
        .then((value) {
      widget.definition = value;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  FlutterTts flutterTts = FlutterTts();
  // @override
  // void dispose() async {

  // flutterTts.setCompletionHandler(() async {
  // await flutterTts.sto

  // setState(() {});
  // });

  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        _words = value;
        // SavedWords.savedWords = value!;
        setState(() {});
      });
    });
    final bool alreadySaved = _words?.contains(widget.word) ?? false;
    setState(() {});

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Word Detail Page'),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.definition != null) {
                Share.share(
                    "word: ${widget.word.toString()} \n Definition: ${widget.definition?[0].text.toString()}");
              }
            },
            icon: Icon(Icons.share),
          ),
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
                              widget.word ?? "",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  if (widget.definition != null &&
                                      widget.example != null) {
                                    // Future.delayed(Duration(seconds: 1),
                                    //     () async {
                                    await flutterTts.speak(widget.word ?? "");
                                    // }
                                    // );

                                    // for (int i = 0;
                                    //     i < widget.definition!.length;
                                    //     i++) {
                                    //   Future.delayed(Duration(seconds: 3),
                                    //       () async {
                                    //     flutterTts.speak(
                                    //         await widget.definition?[i].text ??
                                    //             "");
                                    //   });
                                    // }
                                    // for (int i = 0;
                                    //     i < widget.example!.examples!.length;
                                    //     i++) {
                                    //   Future.delayed(Duration(seconds: 5),
                                    //       () async {
                                    //     await flutterTts.speak(
                                    //         widget.example?.examples?[i].text ??
                                    //             "");
                                    //   });
                                    // }
                                  }
                                },
                                icon: Icon(Icons.volume_up)),
                            isUserLoggedIn
                                ? IconButton(
                                    onPressed: () {
                                      // if (_words != null) {
                                      //   if (SavedWords.savedWords
                                      //       .contains(widget.word ?? "")) {
                                      //     SavedWords.savedWords
                                      //         .remove(widget.word ?? "");
                                      //     // setState(() {});
                                      //   } else {
                                      //     SavedWords.savedWords
                                      //         .add(widget.word ?? "");
                                      //     // setState(() {});
                                      //   }
                                      // }
                                      LocalDataSaver.getSaveWord()
                                          .then((value) {
                                        setState(() {
                                          _words = value;
                                          if (_words != null) {
                                            if (_words!.contains(widget.word)) {
                                              _words!.remove(widget.word);
                                              LocalDataSaver.setSaveWord(
                                                  _words!);
                                            } else {
                                              _words!.add(widget.word ?? "");
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
                        ),
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
                          itemCount: widget.definition?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.definition?[index].text ??
                                    "" + "\n"),
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
                                Text(widget.example?.examples?[index].text ??
                                    ""),
                                SizedBox(height: 10),
                              ],
                            );
                          }),
                          itemCount: widget.example?.examples?.length ?? 0,
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
