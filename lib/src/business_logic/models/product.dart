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

  late String imgUrl;
  late int seens;
  late double newPrice;
  late double discount;

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
    this.imgUrl = "", // TODO: Make it Null.
    this.discount = 0, // TODO: Reconsider
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
    // TODO: Get from backend.
    discount = 15;
    firstDiscountDate = DateTime.parse(json['firstDate']);
    secondDiscountDate = DateTime.parse(json['secondDate']);
    thirdDiscountDate = DateTime.parse(json['thirdDate']);
    firstDiscount = (json['firstDiscount'] as int).toDouble();
    secondDiscount = (json['secondDiscount'] as int).toDouble();
    thirdDiscount = (json['thirdDiscount'] as int).toDouble();
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
