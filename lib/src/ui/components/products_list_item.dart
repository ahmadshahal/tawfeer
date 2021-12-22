import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Container(
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
                    product.productTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
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
            const SizedBox(width: 20),
            _seensColumn(context),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget _productImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 9.0,
        top: 9.0,
        bottom: 9.0,
        right: 12,
      ),
      child: Container(
        height: 65,
        width: 65,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Image.network(
          product.imgUrl,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset(
              'assets/images/tawfeer_logo.png',
            );
          },
        ),
      ),
    );
  }

  Widget _priceRow(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${product.newPrice}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(width: 15.0),
        if (product.newPrice != product.oldPrice)
          Text(
            '\$${product.oldPrice}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.darkGrey,
              decoration: TextDecoration.lineThrough,
              fontSize: 12.0,
            ),
          ),
      ],
    );
  }

  Widget _dateText(BuildContext context) {
    return Text(
      // !: DateFormat("yyyy-MM-dd") to return it as 2020-05-03
      'Expires in ${DateFormat.yMMMd().format(product.expireDate)}',
      style: const TextStyle(
        color: MyColors.darkGrey,
        fontFamily: 'Saira',
        fontSize: 12.0,
      ),
    );
  }

  Widget _seensColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.remove_red_eye_rounded,
          color: MyColors.darkGrey,
          size: 15,
        ),
        Text(
          '${product.seens}',
          style: const TextStyle(fontSize: 11.0, color: MyColors.darkGrey),
        ),
      ],
    );
  }
}
