class Product {
  late int? id;
  late int ownerId;
  late String productTitle;
  late String description;
  late double oldPrice;
  late DateTime expireDate;
  late String category;
  late int quantity;

  late String imgUrl;
  late int seens;
  late double newPrice;

  late DateTime? firstDiscountDate;
  late DateTime? secondDiscountDate;
  late DateTime? thirdDiscountDate;
  late double? firstDiscount;
  late double? secondDiscount;
  late double? thirdDiscount;

  Product({
    this.id,
    required this.ownerId,
    required this.productTitle,
    required this.description,
    required this.oldPrice,
    required this.expireDate,
    required this.category,
    required this.quantity,
    this.newPrice = 10, // TODO: Reconsider
    this.seens = 0, // TODO: Reconsider
    this.imgUrl = "", // TODO: Reconsider
    this.firstDiscountDate,
    this.secondDiscountDate,
    this.thirdDiscountDate,
    this.firstDiscount,
    this.secondDiscount,
    this.thirdDiscount,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    productTitle = json['productName'];
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
