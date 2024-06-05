import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

import 'widgets/note_list.dart';
import 'widgets/settings_list.dart';
import 'widgets/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping Note'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedTab = 2; //0: Home 1: Note 2: Settings

  //Fetch from APIs
  static final listProducts = [
    Product(name: 'Fish', price: 100),
    Product(name: 'Egg', price: 100),
    Product(name: 'Butter', price: 100),
    Product(name: 'Meat', price: 100),
  ];

  List<Widget> widgetOptions = [
    ShoppingList(
      listProducts: listProducts,
    ),
    NoteList(),
    SettingsList(),
  ];

  Future showMyDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User Profile'),
            content: SingleChildScrollView(
              child: ListBody(children: [Text('Remember shopping items')]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // ElevatedButton.icon(
          //     onPressed: () => print('Notification presses'),
          //     icon: Icon(Icons.notifications),
          //     label: Text('Notification')),
          IconButton(
              onPressed: () {
                print('Notification Pressed');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Snackbar shown by user click on notification')));
              },
              icon: Icon(Icons.notifications)),
          IconButton(
            onPressed: () => showMyDialog(),
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            tooltip: 'Profile',
          )
        ],
      ),
      body: widgetOptions[selectedTab],
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.amberAccent),
                child: Text(
                  'Shopping Note',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                print("Drawer on tap Home");
                setState(() {
                  selectedTab = 0;
                });
                Navigator.of(context).pop;
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Note'),
              onTap: () {
                print("Drawer on tap note");
                setState(() {
                  selectedTab = 1;
                });
                Navigator.of(context).pop;
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                print("Drawer on tap settings");
                setState(() {
                  selectedTab = 2;
                });
                Navigator.of(context).pop;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: "Note"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
          print("Bottom navigation bar on Tap index: $index");
        },
      ),
    );
  }
}
