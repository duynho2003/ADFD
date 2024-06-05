import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper_cart/models/cart.dart';
import 'package:shopper_cart/routers/app_router.dart';

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
          return CartModel();
        },
        child: MaterialApp.router(
          title: 'Shopper cart',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router(),
        ));
  }
}
