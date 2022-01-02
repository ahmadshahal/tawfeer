import 'package:flutter/material.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/product_loading.png',
            height: 200,
            width: 280,
          ),
          const SizedBox(height: 30),
          const Text('Product is loading..'),
          const SizedBox(height: 30),
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
