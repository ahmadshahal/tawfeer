import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class ProductsListItem extends StatelessWidget {
  const ProductsListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: MyColors.lightGrey,
      ),
      child: Row(
        children: [
          _productImage(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.darkGrey,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 1.0),
                _priceRow(context),
                const SizedBox(height: 1.0),
                _dateText(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Image.network(
          product.imgUrl,
          height: 70,
          width: 70,
        ),
      ),
    );
  }

  Widget _priceRow(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${product.newPrice}.00',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: MyColors.primaryColor,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(width: 20.0),
        Text(
          '\$${product.newPrice}.00',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: MyColors.darkGrey,
            decoration: TextDecoration.lineThrough,
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  Widget _dateText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Expires in ',
        style: const TextStyle(
          color: MyColors.darkGrey,
          fontFamily: 'Saira',
          fontSize: 13.0,
        ),
        children: [
          TextSpan(
            text: product.expireDate,
            style: const TextStyle(
              color: MyColors.darkGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

