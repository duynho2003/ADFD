import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/laptop_store_view_model.dart';
import 'view/main_page.dart';
import 'view/add_laptop_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LaptopStoreViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laptop Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        '/add-laptop': (context) => AddLaptopPage(),
      },
    );
  }
}
