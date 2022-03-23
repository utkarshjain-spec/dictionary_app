import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dictionary_app/models/random_words.dart';
import 'package:dictionary_app/screens/day_of_words.dart';
import 'package:dictionary_app/screens/history.dart';
import 'package:dictionary_app/screens/login_page.dart';
import 'package:dictionary_app/screens/save_words.dart';
import 'package:dictionary_app/screens/search_word_detail_page.dart';
import 'package:dictionary_app/screens/setting_page.dart';
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
  bool isDayWordLoading = false;
  bool isWordOfDaysLoading = false;

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
    dictionaryWordState.getDayWord(date).then((value) {
      isDayWordLoading = true;
      setState(() {});
    });
    dictionaryWordState.getRandomWord().then((value) {
      isWordOfDaysLoading = true;
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
          // height: double.infinity,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                child: ListView(
                  children: <Widget>[
                    Container(
                      color: Color.fromARGB(255, 38, 46, 53),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                                size: 50,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              isUserLoggedIn ? currentUserName ?? "" : "Guest",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.save,
                            size: 23,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Save Word'),
                        ],
                      ),
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
                      title: Row(
                        children: [
                          Icon(
                            Icons.history,
                            size: 23,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('History'),
                        ],
                      ),
                      onTap: () {
                        //  Navigator.pop(context);
                        // if (isUserLoggedIn) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HistoryClass();
                        }));
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 23,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(' Word of days'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DayOfWords();
                        }));
                        // Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 23,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Settings'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AppSetting();
                        }));
                        // Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(child: Text("version 1.0.0"))),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 85, 134),
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
        body: SafeArea(
          child: SingleChildScrollView(
              child: LayoutBuilder(builder: ((context, constraints) {
            if (isDayWordLoading && isWordOfDaysLoading) {
              return Container(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<WordState>(
                          builder: (BuildContext context, value, child) {
                        return value.dayWord?.word != null
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                  dailyWord:
                                                      value.dayWord?.word ?? "",
                                                )));
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Word of the day",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  value.dayWord?.word ?? "",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      flutterTts.speak(
                                                          value.dayWord?.word ??
                                                              "");
                                                    },
                                                    icon: Icon(Icons.volume_up))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              "${value.dayWord?.publishDate?.year.toString() ?? ""}-${value.dayWord?.publishDate?.month.toString() ?? ""}-${value.dayWord?.publishDate?.day.toString() ?? ""}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              )
                            : CircularProgressIndicator();
                      }),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Some other Words",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      randomWordModel != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: randomWordModel?.length ?? 0,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      width: double.infinity,
                                      child: InkWell(
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
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 2,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          randomWordModel?[
                                                                      index]
                                                                  .word ??
                                                              "",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black)),
                                                      IconButton(
                                                          onPressed: () {
                                                            flutterTts.speak(
                                                                randomWordModel?[
                                                                            index]
                                                                        .word ??
                                                                    "");
                                                          },
                                                          icon: Icon(
                                                              Icons.volume_up))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  })),
                            )
                          : Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }))),
        ));
  }
}
