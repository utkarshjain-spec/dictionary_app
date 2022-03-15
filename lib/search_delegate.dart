import 'package:dictionary_app/models/random_words.dart';
import 'package:dictionary_app/screens/search_word_detail_page.dart';
import 'package:dictionary_app/states/day_word_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  List<String> data = [];

  List<String> recentSearch = [
    // "Android",
    // "Windows",
    // "Mac",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != null && data.contains(query.toLowerCase())) {
      return ListTile(
        title: Text(query),
      );
    } else if (query == "") {
      return Text("");
    } else {
      return ListTile(
        title: Text("No results found"),
        onTap: () {},
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<RandomWordModel> randomWords;
    Provider.of<WordState>(context, listen: false)
        .getRandomWord()
        .then((value) {
      randomWords = value;
      // print(value[0].word);
      for (int i = 0; i < randomWords.length; i++) {
        data.add(value[i].word.toString());
      }
    });

    final suggestions = query.isEmpty
        ? recentSearch
        : data.where((element) {
            return element.toLowerCase().contains(query.toLowerCase());
          }).toList();

    return buildSuggestionsSuccess(suggestions);

    // return ListView.builder(
    //     itemCount: recentSearch.length,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         title: Text(recentSearch[index]),
    //         trailing: Icon(
    //           Icons.arrow_forward_ios,
    //         ),
    //         onTap: () {},
    //       );
    //     });
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) {
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchWordDetailPage(word: suggestions[index]);
              }));
            },
          );
        });
  }
}
