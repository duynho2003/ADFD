class Item {
  //fake get from apis
  static List<String> images = [
    'images/product-01.jpg',
    'images/product-02.jpg',
    'images/product-03.jpg',
    'images/product-04.jpg',
    'images/product-05.jpg',
    'images/product-06.jpg',
    'images/product-07.jpg',
  ];

  final int id;
  final String name;
  final String image;
  final int price;

  Item(this.id, this.name)
      : image = images[id % images.length],
        price = 0;

  @override
  int get hashCode => id;

  @override
  bool operator == (Object other) {
    return other is Item && other.id == id;
  }
}
