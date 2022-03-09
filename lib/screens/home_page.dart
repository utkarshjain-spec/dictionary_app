import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/models/day_word_model.dart';
import 'package:dictionary_app/screens/word_detail_page.dart.dart';
import 'package:dictionary_app/search_delegate.dart';
import 'package:dictionary_app/states/day_word_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    Provider.of<WordState>(context, listen: false).getDayWord();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                    context: context, delegate: Search(), query: "");
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: Consumer<WordState>(builder: (BuildContext context, value, child) {
        return Column(
          children: [
            Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(value.dayWord?.word ?? "",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            IconButton(
                                onPressed: () {
                                  Provider.of<WordState>(context, listen: false)
                                      .getWordSound(value.dayWord?.word ?? "")
                                      .then((value) {
                                    audioPlayer.play(value.fileUrl!);
                                  });
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
                                    builder: (context) => DetailPage()));
                          },
                          child: Text("Click here to more detail",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue)),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        );
      }),
    );
  }
}
