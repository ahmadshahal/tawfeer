import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/components/products_list_item.dart';

class MyListView extends StatelessWidget {
  const MyListView({Key? key, required this.list}) : super(key: key);

  final List<Product> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ProductsListItem(product: list[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15.0);
      },
      itemCount: list.length,
    );
  }
}
