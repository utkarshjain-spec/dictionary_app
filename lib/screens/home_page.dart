import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/screens/login_page.dart';
import 'package:dictionary_app/screens/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dictionary_app/models/random_words.dart';
import 'package:dictionary_app/screens/day_of_words.dart';
import 'package:dictionary_app/screens/history.dart';
import 'package:dictionary_app/screens/save_words.dart';
import 'package:dictionary_app/screens/search_word_detail_page.dart';
import 'package:dictionary_app/screens/word_detail_page.dart.dart';
import 'package:dictionary_app/search_delegate.dart';
import 'package:dictionary_app/states/day_word_state.dart';

class HomePage extends StatefulWidget {
  // String userName;
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUserLoggedIn = false;
  String? currentUserName;
  Future<bool?> checkUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    if (user != null) {
      currentUserName = user.displayName.toString();
      isUserLoggedIn = true;
      setState(() {});
    } else {
      isUserLoggedIn = false;
      setState(() {});
    }
  }

  List<RandomWordModel>? randomWordModel;
  late DateTime _dateTime;
  String? date;

  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    checkUser();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    var dictionaryWordState = Provider.of<WordState>(context, listen: false);
    _dateTime = DateTime.now();
    date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();
    dictionaryWordState.getDayWord(date);
    dictionaryWordState.getRandomWord().then((value) {
      randomWordModel = value;
      setState(() {});
    });
    // });
    // TODO: implement initState
    super.initState();
  }

  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView(
            children: <Widget>[
              Container(
                color: Color.fromARGB(255, 27, 93, 146),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                  child: Text(
                    isUserLoggedIn ? currentUserName ?? "" : "Guest",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              // DrawerHeader(
              //   child: Text('Drawer Header'),
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              // ),
              ListTile(
                title: Text('Save Word'),
                onTap: () {
                  // LocalDataSaver.setSaveWord(SavedWords.savedWords);
                  // Navigator.pop(context);
                  if (isUserLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaveWordsClass(),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    // SnackBar(content: Text('Please Login First'));
                    final snackBar = SnackBar(
                      content: Text('Please Login First'),
                      action: SnackBarAction(
                        label: 'Login',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                          // Some code to undo the change.
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              ListTile(
                title: Text('History'),
                onTap: () {
                  //  Navigator.pop(context);
                  if (isUserLoggedIn) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HistoryClass();
                    }));
                  } else {
                    Navigator.pop(context);
                    // SnackBar(content: Text('Please Login First'));
                    final snackBar = SnackBar(
                      content: Text('Please Login First'),
                      action: SnackBarAction(
                        label: 'Login',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                          // Some code to undo the change.
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              ListTile(
                title: Text(' Word of days'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DayOfWords();
                  }));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AppSetting();
                  }));
                  // Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 50,
              ),
              Center(child: Text("version 1.0.0")),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(isUserLoggedIn ? currentUserName ?? "" : 'Guest'),
          actions: [
            IconButton(
                onPressed: () async {
                  await showSearch(
                      context: context, delegate: Search(), query: "");
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Share.share(
                    "https://github.com/X-Wei/flutter_catalog/blob/master/lib/routes/appbar_search_ex.dart",
                  );
                },
                icon: Icon(Icons.share)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<WordState>(
                  builder: (BuildContext context, value, child) {
                return value.dayWord?.word != null
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: double.infinity,
                        child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Word of the Day",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value.dayWord?.word ?? "",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                      IconButton(
                                          onPressed: () {
                                            flutterTts.speak(
                                                value.dayWord?.word ?? "");

                                            // Provider.of<WordState>(context, listen: false)
                                            //     .getWordSound(value.dayWord?.word ?? "")
                                            //     .then((value) {
                                            //   audioPlayer.play(value.fileUrl!);
                                            // });
                                          },
                                          icon: Icon(Icons.volume_up))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${value.dayWord?.publishDate?.year.toString() ?? ""}-${value.dayWord?.publishDate?.month.toString() ?? ""}-${value.dayWord?.publishDate?.day.toString() ?? ""}",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                    dailyWord:
                                                        value.dayWord?.word ??
                                                            "",
                                                  )));
                                    },
                                    child: Text("Click here to more detail",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue)),
                                  ),
                                ],
                              ),
                            )),
                      )
                    : CircularProgressIndicator();
              }),
              SizedBox(
                height: 10,
              ),
              Text(
                "Word of days",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              randomWordModel != null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                          itemCount: randomWordModel?.length ?? 0,
                          itemBuilder: ((context, index) {
                            return Container(
                              width: double.infinity,
                              child: Card(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ),
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                randomWordModel?[index].word ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)),
                                            IconButton(
                                                onPressed: () {
                                                  flutterTts.speak(
                                                      randomWordModel?[index]
                                                              .word ??
                                                          "");
                                                },
                                                icon: Icon(Icons.volume_up))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchWordDetailPage(
                                                          word: randomWordModel
                                                                  ?.elementAt(
                                                                      index)
                                                                  .word ??
                                                              "",
                                                        )));
                                          },
                                          child: Text(
                                              "Click here to more detail",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue)),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          })),
                    )
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        ));
  }
}
