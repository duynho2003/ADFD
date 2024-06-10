import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Products',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      actions: [
        IconButton(
            onPressed: () {
              context.push('/cart');
            },
            icon: Icon(Icons.shop))
      ],
    );
  }
}
