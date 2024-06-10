import 'package:flutter/material.dart';
import 'package:shopper_cart/widgets/my_appbar.dart';
import 'package:shopper_cart/widgets/my_listitem.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      MyAppBar(),
      SliverToBoxAdapter(
        child: SizedBox(height: 12),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return MyListItem(index);
          },
        ),
      ),
    ]));
  }
}
