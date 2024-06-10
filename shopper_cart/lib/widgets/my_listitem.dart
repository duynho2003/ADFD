import 'package:flutter/material.dart';
import 'package:shopper_cart/services/product_service.dart';
import 'package:shopper_cart/widgets/add_button.dart';

class MyListItem extends StatelessWidget {
  final int index;

  const MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = ProductService.getById(index);
    var textTheme = Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            Image.asset(
              item.image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
