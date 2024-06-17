class Laptop {
  String model;
  double price;
  bool thin;

  Laptop({
    required this.model,
    required this.price,
    required this.thin,
  });

  @override
  String toString() {
    return 'Model: $model, Price: $price, Thin: $thin';
  }
}