import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Products Screen',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.secondaryColor,
        ),
      ),
    );
  }
}
