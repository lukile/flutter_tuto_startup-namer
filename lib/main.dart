import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

//Stateless is immutable : properties can't change, all values are final
class MyApp extends StatelessWidget {
  @override
  //In flutter almost everything is Widget
  //build method describes how to display the widget in terms of other lower level widgets
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Welcome to Flutter',
      //Scaffold is a widget provides default app bar, title and body properties
      //home: Scaffold(
      title: 'Startup Name Generator',
        home: RandomWords(),
        //appBar: AppBar(
          //title: Text('Welcome to Flutter'),
        //),
        //body: Center(
         // child: RandomWords(),
        );
     // ),
    //);
  }
}

//Most of the app's logic is in State, maintains the state for RandomWords widget
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    //"_" prefix enforces privacy in Dart
    final _suggestions = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);

    //Display each new pairs in a ListTile allows to maje the rows more attractive
    Widget _buildRow(WordPair pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    }

    Widget _buildSuggestions() {
      return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          //itemBuilder called once per suggested word pairing and places suggestion into a ListTite row
          //even row -> adds a ListTite row for the word pairing
          //odd row -> adds a Divider widget to separate entries
          itemBuilder: (context, i) {
            //Add a one pixel divider widget before each row in ListView
            if (i.isOdd) return Divider();

            //divides i by 2 and returns an integer result
            final index = i ~/2;
            if(index >= _suggestions.length) {
              //if the end is reached, generate 10 more word pairings and add them to suggestion list
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          });
    }

    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );

  }
}

//Stateful maintains the state, which can change during widget lifetime
//Requires two classes :
// StatefulWidget  (creates the instance)
// State (class)
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}