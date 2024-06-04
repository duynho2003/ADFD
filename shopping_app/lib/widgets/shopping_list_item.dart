import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final Function(Product product)? onTap;

  const ShoppingListItem(
      {super.key, required this.product, required this.inCart, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color color = inCart ? Colors.grey : Color.fromRGBO(138, 189, 112, 0.694);
    TextStyle style = inCart
        ? TextStyle(decoration: TextDecoration.lineThrough)
        : TextStyle(color: Colors.white);
    TextStyle? styleTitle = inCart ? TextStyle(decoration: TextDecoration.lineThrough) : null;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          product.name.substring(0, 1),
          style: style,
        ),
      ),
      title: Text(product.name,style: styleTitle,),
      subtitle: Text('${product.price}'),
      onTap: () => onTap != null && onTap!(product),
    );
  }
}