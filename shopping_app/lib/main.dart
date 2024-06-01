import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 138, 78, 242)),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              print("Notification pressed");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Notification pressed"),
                ),
              );
            },
            icon: Icon(Icons.notifications),
            tooltip: "Notification",
          ),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Profile Dialog"),
                  content: Text("This is a profile dialog."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                  ],
                );
              },
            ),
            icon: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            tooltip: "Profile",
          ),
        ],
      ),
    );
  }
}
