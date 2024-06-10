import 'package:flutter/material.dart';
import 'package:shopper_cart/models/item.dart';
import 'package:shopper_cart/services/product_service.dart';

class CartModel extends ChangeNotifier {
  List<int> _itemIds = [];

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }

  List<Item> get items =>
      _itemIds.map((id) => ProductService.getById(id)).toList();

  int get totalPrice => items.fold(0, (previousValue, item) => previousValue + item.price);
}
