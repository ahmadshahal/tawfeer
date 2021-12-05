import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/components/my_drawer.dart';
import 'package:tawfeer/src/ui/screens/modules/products_screen.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const ProductsScreen(),
      floatingActionButton: _floatingActionButton(context),
      drawer: const MyDrawer(),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 2.0,
      backgroundColor: MyColors.secondaryColor,
      title: const Text(
        'Products',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.white,
          ),
          splashRadius: 20.0,
        ),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: const Icon(
            Icons.more_vert,
            color: MyColors.white,
          ),
          splashRadius: 20.0,
        ),
      ],
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // TODO
      },
      child: const Icon(Icons.add),
    );
  }
}
