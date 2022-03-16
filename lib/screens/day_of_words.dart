import 'package:dictionary_app/screens/search_word_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../states/day_word_state.dart';

class DayOfWords extends StatefulWidget {
  const DayOfWords({Key? key}) : super(key: key);

  @override
  State<DayOfWords> createState() => _DayOfWordsState();
}

class _DayOfWordsState extends State<DayOfWords> {
  bool isWordLoaded = false;
  FlutterTts _flutterTts = FlutterTts();
  String? word;
  late DateTime _dateTime;
  String? date;
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();
    var wordState = Provider.of<WordState>(context, listen: false);
    wordState.getSelectedDateWOrd(date).then((value) {
      if (wordState.dayWord1?.word != null) {
        word = wordState.dayWord1?.word ?? "";
        isWordLoaded = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 85, 134),
        title: Text('Day of Word'),
      ),
      body: Column(
        children: [
          Consumer(builder: (BuildContext context, value, Widget? child) {
            return Container(
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchWordDetailPage(
                                word: word ?? "",
                              )));
                },
                child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Word of the Date ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isWordLoaded
                                  ? Text(word ?? "",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                  : CircularProgressIndicator(),
                              IconButton(
                                  onPressed: () {
                                    _flutterTts.speak(word ?? "");
                                  },
                                  icon: Icon(Icons.volume_up))
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
          TableCalendar(
            pageJumpingEnabled: true,
            focusedDay: _dateTime,
            firstDay: DateTime(2022),
            lastDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_dateTime, day);
            },
            onDaySelected: (date1, focusedDay) {
              isWordLoaded = false;
              setState(() {});
              _dateTime = date1;

              date = date1.year.toString() +
                  '-' +
                  date1.month.toString() +
                  '-' +
                  date1.day.toString();

              var wordState = Provider.of<WordState>(context, listen: false);
              wordState.getSelectedDateWOrd(date).then((value) {
                if (wordState.dayWord1?.word != null) {
                  isWordLoaded = true;
                  word = wordState.dayWord1?.word ?? "";
                  setState(() {});
                }
              });
            },
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 25, 85, 134),
                  shape: BoxShape.circle
                  // borderRadius: BorderRadius.circular(10),
                  ),
              selectedDecoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
