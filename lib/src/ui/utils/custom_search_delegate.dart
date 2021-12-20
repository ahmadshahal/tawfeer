import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/components/my_list_view.dart';

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
    List<Product> matchQuery = [];
    for (Product product in products) {
      if (product.category.toLowerCase().contains(query.toLowerCase()) ||
          product.productTitle.toLowerCase().contains(query.toLowerCase()) ||
          product.newPrice
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
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
              MyListView(list: matchQuery),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchQuery = [];
    for (Product product in products) {
      if (product.category.toLowerCase().contains(query.toLowerCase()) ||
          product.productTitle.toLowerCase().contains(query.toLowerCase()) ||
          product.newPrice
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
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
              MyListView(list: matchQuery),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
