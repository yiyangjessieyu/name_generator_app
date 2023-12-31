import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

/// MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // Create state
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Name Generator App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// Manage the state of the app by defining the data it needs to function
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favourites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavourites() {
    if (favourites.contains(current)) {
      favourites.remove(current);
    } else {
      favourites.add(current);
    }
    print("[LOG]");
    print(favourites);
    notifyListeners();
  }
}

// This widget is the home page of your application.
class MyHomePage extends StatelessWidget {
  // This method is rerun every time setState is called
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // TEXT
            BigCard(pair: pair),
            SizedBox(height: 10,),
      
            // BUTTON
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () { appState.toggleFavourites(); }, 
                  child: Text('Love')
                ),
                ElevatedButton(
                  onPressed: () { appState.getNext(); }, 
                  child: Text('Next')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, style: style, semanticsLabel: pair.asPascalCase,),
      ),
    );
  }
}