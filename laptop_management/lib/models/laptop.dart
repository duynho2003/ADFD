class LaptopModel {
  final String id;
  final String model;
  final double price;
  final int isThin;

  LaptopModel(
      {required this.id,
      required this.model,
      required this.price,
      required this.isThin});

  factory LaptopModel.formJson(Map<String, dynamic> json) {
    return LaptopModel(
        id: json['id'] as String,
        model: json['model'] as String,
        price: json['price'] as double,
        isThin: json['isThin'] as int);
  }

  Map<String, dynamic> toMap() =>
      {'id': id, 'model': model, 'price': price, 'isThin': isThin};
}