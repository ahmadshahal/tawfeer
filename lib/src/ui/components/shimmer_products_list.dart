import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/components/shimmer_product_list_item.dart';

class ShimmerProductsList extends StatelessWidget {
  const ShimmerProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return const ShimmerProductListItem();
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15.0);
              },
              itemCount: 7,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
