import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/provider/world_provider.dart';
import 'package:namer_app/widgets/bigcard.dart';

import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ← 1
    var appState = context.watch<MyAppState>();
    var pair = appState.current; // ← 2
    IconData icon;
    if (appState.favourites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    Widget page;
    print('Selected Index: $selectedIndex');
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage(pair: pair, appState: appState, icon: icon);
      case 1:
        page = FavouritePage();
      default:
        page = Placeholder();
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
              child: NavigationRail(
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text("Home")),
              NavigationRailDestination(
                  icon: Icon(Icons.favorite), label: Text("Favourite")),
            ],
            selectedIndex: 0,
            onDestinationSelected: (index) {
              print("On Destination selected: $index");
              setState(() {
                selectedIndex = index;
              });
            },
          )),
          Expanded(child: Container(color: Colors.lightBlue, child: page)),
        ],
      ),
    );
  }
}

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favourites; // ← 2
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('You have ${favorites.length} in your list:'),
        ),
        for (var pair in favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
            trailing: IconButton(
              // Add a trailing IconButton
              icon: Icon(Icons.delete),
              onPressed: () {
                appState.removeFavorite(pair);
              },
            ),
          ),
      ],
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({
    super.key,
    required this.pair,
    required this.appState,
    required this.icon,
  });

  final WordPair pair;
  final MyAppState appState;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A random AWESOME idea:'),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     print('button pressed!');
              //     appState.getNext();
              //   },
              //   child: Text('Next'),
              // ),
              // ↓ And this.
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavourite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10), // Added some space between buttons
              ElevatedButton(
                onPressed: () {
                  print('On next!');
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
