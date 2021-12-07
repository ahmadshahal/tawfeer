class Product {
  late int id;
  late String productName;
  late String description;
  late int oldPrice;
  late int newPrice;
  late DateTime expireDate;
  late String category;
  late int quantity;
  late String imgUrl;
  late int seens;

  Product({
    required this.id,
    required this.productName,
    required this.description,
    required this.oldPrice,
    required this.newPrice,
    required this.expireDate,
    required this.category,
    required this.quantity,
    required this.imgUrl,
    required this.seens,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    oldPrice = json['oldPrice'];
    newPrice = json['newPrice'];
    description = json['description'];
    expireDate = DateTime.parse(json['expireDate']);
    imgUrl = json['imgUrl'];
    category = json['category'];
    quantity = json['quantity'];
    seens = json['seens'];
  }
}
