class Product {
  late String name;
  late double price;

  Product({String name = '', double price = 0}) {
    this.name = name;
    this.price = price;
  }
  get getName => this.name;

  set setName(name) => this.name = name;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;
}
