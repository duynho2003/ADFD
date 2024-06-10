import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper_cart/models/cart.dart';

class AddButton extends StatelessWidget {
  final item;
  const AddButton({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart =
        context.select<CartModel, bool>((cart) => cart.items.contains(item));
    return isInCart
        ? Icon(Icons.check)
        : TextButton(
            onPressed: () {
              var cart = context.read<CartModel>();
              cart.add(item);
            },
            child: Text('ADD'));
  }
}
