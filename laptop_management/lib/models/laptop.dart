class LaptopModel {
  final String id;
  final String model;
  final double price;
  final bool thin;

  LaptopModel(
      {required this.id,
      required this.model,
      required this.price,
      required this.thin});

  factory LaptopModel.formJson(Map<String, dynamic> json) {
    return LaptopModel(
        id: json['id'] as String,
        model: json['model'] as String,
        price: json['price'] as double,
        thin: json['thin'] as bool );
  }

  Map<String, dynamic> toMap() =>
      {'id': id, 'model': model, 'price': price, 'thin': thin};
}