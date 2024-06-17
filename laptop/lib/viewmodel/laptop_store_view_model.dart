import 'package:flutter/foundation.dart';
import '../model/laptop.dart';

class LaptopStoreViewModel extends ChangeNotifier {
  List<Laptop> _laptops = [];

  List<Laptop> get laptops => _laptops;

  void saveLaptop(Laptop laptop) {
    _laptops.add(laptop);
    notifyListeners();
  }

  void removeLaptop(String model) {
    _laptops.removeWhere((laptop) => laptop.model == model);
    notifyListeners();
  }
}
