import 'package:dictionary_app/local_data_saver.dart';
import 'package:dictionary_app/screens/search_word_detail_page.dart';
import 'package:flutter/material.dart';

class SaveWordsClass extends StatefulWidget {
  const SaveWordsClass({Key? key}) : super(key: key);

  @override
  State<SaveWordsClass> createState() => _SaveWordsClassState();
}

class _SaveWordsClassState extends State<SaveWordsClass> {
  List<String> _words = [];

  @override
  void initState() {
    LocalDataSaver.getSaveWord().then((value) {
      setState(() {
        if (value != null) {
          _words = value;
        }
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Saved Words'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _words.length != null ? _words.length : 0,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchWordDetailPage(
                                    word: _words[index],
                                  )));
                    }),
                    child: ListTile(
                      title: Text("${index + 1}. " + _words[index]),
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
