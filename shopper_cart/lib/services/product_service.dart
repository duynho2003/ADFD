import 'package:shopper_cart/models/item.dart';

class ProductService {
  static List<String> itemNames = [
    'Zesco Ripe Bananas',
    'Orange Peel Zest',
    'Tesco Green Seedless',
    'Waterfi SwimActive',
    'Heisenbug',
    'Spaghetti',
    'Tescot Coconut',
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  static Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  static Item getByPosition(int position) {
    return getById(position);
  }
}