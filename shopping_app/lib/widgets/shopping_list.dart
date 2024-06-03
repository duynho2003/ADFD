import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/widgets/shopping_list_item.dart';

class ShoppingList extends StatefulWidget {
  final List<Product> listProducts;

  const ShoppingList({super.key, required this.listProducts});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final cartChecked = <Product>{};
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.listProducts
          .map((product) => ShoppingListItem(
                product: product,
                inCart: cartChecked.contains(product),
              ))
          .toList(),
    );
  }
}
