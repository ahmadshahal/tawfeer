import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/components/my_list_view.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> products;

  CustomSearchDelegate({required this.products});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear_rounded),
        splashRadius: 20.0,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 20.0,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _userMsg(context, 'Search for a product..', 'assets/images/search.png');
    }
    List<Product> matchQuery = [];
    for (Product product in products) {
      if (query.isNotEmpty &&
          (product.category.toLowerCase().contains(query.toLowerCase()) ||
              product.productTitle
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              product.newPrice
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.expireDate.day.toString().contains(query) ||
              product.expireDate.month.toString().contains(query) ||
              product.expireDate.year.toString().contains(query))) {
        matchQuery.add(product);
      }
    }
    if (matchQuery.isEmpty) {
      return _userMsg(context, 'No Results..', 'assets/images/no_items.png');
    }
    return _resultsList(context, matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  Widget _resultsList(BuildContext context, List<Product> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        // To make the single child scroll view go to the end
        // without something clipped when scrolling.
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              MyListView(list: list),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userMsg(BuildContext context, String msg, String imgPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 32.0),
      child: Center(
        child: ScrollConfiguration(
          behavior: NonGlowScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imgPath,
                  height: 350,
                  width: 350,
                ),
                Text(msg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
