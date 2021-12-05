class Product {
  late String productName;
  late String description;
  late int oldPrice;
  late int newPrice;
  late String expireDate;
  late String category;
  late int quantity;
  late String imgUrl;

  Product({
    required this.productName,
    required this.description,
    required this.oldPrice,
    required this.newPrice,
    required this.expireDate,
    required this.category,
    required this.quantity,
    required this.imgUrl,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    oldPrice = json['oldPrice'];
    newPrice = json['newPrice'];
    description = json['description'];
    expireDate = json['expireDate'];
    imgUrl = json['imgUrl'];
    category = json['category'];
    quantity = json['quantity'];
  }
}
