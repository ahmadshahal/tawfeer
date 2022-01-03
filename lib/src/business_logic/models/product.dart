import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Product {
  late int? id;
  late int ownerId;
  late String productTitle;
  late String description;
  late double oldPrice;
  late DateTime expireDate;
  late String category;
  late int quantity;

  late int seens;
  late double newPrice;
  late double discount;

  String? imgUrl;

  DateTime? firstDiscountDate;
  DateTime? secondDiscountDate;
  DateTime? thirdDiscountDate;
  double? firstDiscount;
  double? secondDiscount;
  double? thirdDiscount;
  File? imgFile;

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
    this.discount = 0, // TODO: Reconsider
    this.imgUrl,
    this.firstDiscountDate,
    this.secondDiscountDate,
    this.thirdDiscountDate,
    this.firstDiscount,
    this.secondDiscount,
    this.thirdDiscount,
    this.imgFile,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    productTitle = json['productName'];
    oldPrice = (json['oldPrice'] as int).toDouble();
    newPrice = (json['currentPrice'] as int).toDouble();
    description = json['description'];
    expireDate = DateTime.parse(json['expireDate']);
    imgUrl = json['imgUrl'];
    category = json['category'];
    quantity = json['quantity'];
    seens = json['seens'];
    discount = json['currentDiscount'];
    firstDiscountDate = DateTime.parse(json['firstDate']);
    secondDiscountDate = DateTime.parse(json['secondDate']);
    thirdDiscountDate = DateTime.parse(json['thirdDate']);
    firstDiscount = (json['firstDiscount'] as int).toDouble();
    secondDiscount = (json['secondDiscount'] as int).toDouble();
    thirdDiscount = (json['thirdDiscount'] as int).toDouble();
  }

  Map<String, String> toJson() {
    return {
      'productName' : productTitle,
      'description' : description,
      'expireDate' : DateFormat("yyyy-MM-dd").format(expireDate),
      'oldPrice' : oldPrice.toString(),
      'quantity' : quantity.toString(),
      'category' : category,
      if(firstDiscountDate != null)
        'firstDate' : DateFormat("yyyy-MM-dd").format(firstDiscountDate!),
      if(secondDiscountDate != null)
        'secondDate' : DateFormat("yyyy-MM-dd").format(secondDiscountDate!),
      if(thirdDiscountDate != null)
        'thirdDate' : DateFormat("yyyy-MM-dd").format(thirdDiscountDate!),
      if(firstDiscount != null)
        'firstDiscount' : firstDiscount.toString(),
      if(secondDiscount != null)
        'secondDiscount' : secondDiscount.toString(),
      if(thirdDiscount != null)
        'thirdDiscount' : thirdDiscount.toString(),
    };
  }

  Product.special({
    required this.ownerId,
    required this.productTitle,
    required this.category,
    required this.description,
    required String quantity,
    required String expireDate,
    required String oldPrice,
    required String firstDiscountDate,
    required String secondDiscountDate,
    required String thirdDiscountDate,
    required String firstDiscount,
    required String secondDiscount,
    required String thirdDiscount,
    required XFile? xFile,
  }) {
    this.oldPrice = double.parse(oldPrice);
    this.quantity = int.parse(quantity);
    this.expireDate = DateFormat.yMMMd().parse(expireDate);
    if (xFile != null) {
      imgFile = File(xFile.path);
    }
    if (firstDiscountDate.isNotEmpty) {
      this.firstDiscountDate = DateFormat.yMMMd().parse(firstDiscountDate);
    }
    if (secondDiscountDate.isNotEmpty) {
      this.secondDiscountDate = DateFormat.yMMMd().parse(secondDiscountDate);
    }
    if (thirdDiscountDate.isNotEmpty) {
      this.thirdDiscountDate = DateFormat.yMMMd().parse(thirdDiscountDate);
    }
    if (firstDiscount.isNotEmpty) {
      this.firstDiscount = double.parse(firstDiscount);
    }
    if (secondDiscount.isNotEmpty) {
      this.secondDiscount = double.parse(secondDiscount);
    }
    if (thirdDiscount.isNotEmpty) {
      this.thirdDiscount = double.parse(thirdDiscount);
    }
  }
}
