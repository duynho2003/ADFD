import 'package:flutter/material.dart';
import 'package:namer_app/provider/world_provider.dart';
import 'package:namer_app/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { 
        return MyAppState();
       },
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 61, 172, 36)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Random Name Idea'),
      ),
    );
  }
}
