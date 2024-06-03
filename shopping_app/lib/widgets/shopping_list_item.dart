import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/product.dart';

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;

  const ShoppingListItem(
      {super.key, required this.product, required this.inCart});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(234, 47, 187, 34),
        child: Text(
          product.name.substring(0, 1),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(product.name),
      subtitle: Text('${product.price}'),
    );
  }
}
