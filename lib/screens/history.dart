import 'package:dictionary_app/local_data_saver.dart';
import 'package:dictionary_app/screens/search_word_detail_page.dart';
import 'package:flutter/material.dart';

class HistoryClass extends StatefulWidget {
  const HistoryClass({Key? key}) : super(key: key);

  @override
  State<HistoryClass> createState() => _HistoryClassState();
}

class _HistoryClassState extends State<HistoryClass> {
  List<String> _words = [];
  @override
  void initState() {
    LocalDataSaver.getHistory().then((value) {
      if (value != null) {
        _words = value;
      }
      setState(() {});
    });
    // LocalDataSaver.setHistory(_words);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 85, 134),
        title: Text('history of words'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _words.length != null ? _words.length : 0,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchWordDetailPage(
                                    word: _words[index],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Card(
                        child: ListTile(
                          title: Text("${index + 1}. " + _words[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
