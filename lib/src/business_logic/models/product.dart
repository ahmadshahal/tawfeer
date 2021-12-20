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
    this.imgUrl = "", // TODO: Reconsider
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
    oldPrice = json['oldPrice'];
    newPrice = json['newPrice'];
    description = json['description'];
    expireDate = DateTime.parse(json['expireDate']);
    imgUrl = json['imgUrl'];
    category = json['category'];
    quantity = json['quantity'];
    seens = json['seens'];
  }

  Product.special({
    required int myOwnerId,
    required XFile? xFile,
    required String titleT,
    required String categoryT,
    required String quantityT,
    required String expireDateT,
    required String priceT,
    required String firstDiscountDateT,
    required String secondDiscountDateT,
    required String thirdDiscountDateT,
    required String firstDiscountT,
    required String secondDiscountT,
    required String thirdDiscountT,
    required String descriptionT,
  }) {
    ownerId = myOwnerId;
    productTitle = titleT;
    description = descriptionT;
    category = categoryT;
    oldPrice = double.parse(priceT);
    quantity = int.parse(quantityT);
    expireDate = DateFormat.yMMMd().parse(expireDateT);
    if(xFile != null) {
      imgFile = File(xFile.path);
    }
    if(firstDiscountDateT.isNotEmpty) {
      firstDiscountDate = DateFormat.yMMMd().parse(firstDiscountDateT);
    }
    if(secondDiscountDateT.isNotEmpty) {
      secondDiscountDate = DateFormat.yMMMd().parse(secondDiscountDateT);
    }
    if(thirdDiscountDateT.isNotEmpty) {
      thirdDiscountDate = DateFormat.yMMMd().parse(thirdDiscountDateT);
    }
    if(firstDiscountT.isNotEmpty) {
      firstDiscount = double.parse(firstDiscountT);
    }
    if(secondDiscountT.isNotEmpty) {
      secondDiscount = double.parse(secondDiscountT);
    }
    if(thirdDiscountT.isNotEmpty) {
      thirdDiscount = double.parse(thirdDiscountT);
    }
  }
}
