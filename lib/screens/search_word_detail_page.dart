import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dictionary_app/constants.dart';
import 'package:dictionary_app/models/definition_modal.dart';
import 'package:dictionary_app/models/word_example_modal.dart';
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
  int definitionStatusCode = 0;
  int exampleStatusCode = 0;
  List<String>? _words;
  List<String>? _historyWords = [];
  bool isDefinitionLoaded = false;
  bool isExampleLoaded = false;

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
    checkUser();

    LocalDataSaver.getHistory().then((value) {
      setState(() {
        if (value != null) {
          _historyWords = value;
        } else {
          _historyWords = [];
        }
      });
    }).then((value) {
      if (widget.word != null) {
        if (_historyWords?.contains(widget.word) == false) {
          _historyWords?.add(widget.word!);
          LocalDataSaver.setHistory(_historyWords!);
        }
      }
    });

    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        _words = value;
        setState(() {});
      });
    });

    Provider.of<WordState>(context, listen: false)
        .getWordExamples(widget.word ?? "")
        .then((value) {
      isExampleLoaded = true;
      if (value.stateCode != null && value.data != null) {
        widget.example = value.data;
        exampleStatusCode = value.stateCode!;
      }
      if (mounted) {
        setState(() {});
      }
    });
    Provider.of<WordState>(context, listen: false)
        .getWordDefinitions(widget.word ?? "")
        .then((value) {
      isDefinitionLoaded = true;
      if (value.stateCode != null && value.data != null) {
        // value.stateCode == 200
        //     ? widget.definition = value.data
        //     : widget.definition = [];
        definitionStatusCode = value.stateCode!;
        widget.definition = value.data;
      }
      if (mounted) {
        setState(() {});
      }
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
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

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
        backgroundColor: Color.fromARGB(255, 25, 85, 134),
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
      body: SingleChildScrollView(child: LayoutBuilder(
        builder: ((context, constraints) {
          if (isExampleLoaded && isDefinitionLoaded) {
            return Consumer<WordState>(
              builder: (BuildContext context, value, Widget? child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    widget.word ?? "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        String text = "";
                                        if (widget.word != null) {
                                          text = text + widget.word!;
                                        }
                                        if (widget.definition != null) {
                                          for (int i = 0;
                                              i < widget.definition!.length;
                                              i++) {
                                            if (widget.definition![i].text !=
                                                null) {
                                              text = text +
                                                  widget.definition![i].text!;
                                            }
                                          }
                                        }
                                        if (widget.example != null) {
                                          if (widget.example!.examples!.length <
                                              6) {
                                            for (int i = 0;
                                                i <
                                                    widget.example!.examples!
                                                        .length;
                                                i++) {
                                              text = text +
                                                  widget.example!.examples![i]
                                                      .text!;
                                            }
                                          } else {
                                            for (int i = 0; i < 6; i++) {
                                              text = text +
                                                  widget.example!.examples![i]
                                                      .text!;
                                            }
                                          }
                                        }

                                        Future.delayed(
                                            Duration(milliseconds: 100),
                                            () async {
                                          await flutterTts
                                              .speak(parse(text).body!.text);
                                        });
                                      },
                                      icon: Icon(Icons.volume_up)),
                                  isUserLoggedIn
                                      ? IconButton(
                                          onPressed: () {
                                            LocalDataSaver.getSaveWord()
                                                .then((value) {
                                              setState(() {
                                                _words = value;
                                                if (_words != null) {
                                                  if (_words!
                                                      .contains(widget.word)) {
                                                    _words!.remove(widget.word);
                                                    LocalDataSaver.setSaveWord(
                                                        _words!);
                                                  } else {
                                                    _words!
                                                        .add(widget.word ?? "");
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
                      SizedBox(
                        height: 10,
                      ),
                      if (definitionStatusCode == 200)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Definations',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                ListView.builder(
                                  itemCount: widget.definition?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(parse(widget
                                                    .definition?[index].text ??
                                                "No definition Found" + "\n")
                                            .body!
                                            .text),
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
                      if (exampleStatusCode == 200)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Examples',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                ListView.builder(
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.example?.examples?[index]
                                                .text ??
                                            "No Example Found"),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  }),
                                  itemCount:
                                      widget.example?.examples?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }),
      )),
    );
  }
}
