import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To avoid overflow when showing the screen while
      // the keyboard isn't closed.
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productImage(context),
            const SizedBox(height: 20),
            _titlePriceColumn(context),
            const SizedBox(height: 10),
            const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'Description'),
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: NonGlowScrollBehavior(),
                child: TabBarView(
                  children: [
                    _detailsRow(context),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _descriptionText(context),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.black.withOpacity(0.3),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: 20.0,
      ),
      actions: [
        // TODO: Check Ids
        IconButton(
          onPressed: () {
            _showMenu(context);
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

  Widget _productImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.1,
      width: double.infinity,
      color: MyColors.white,
      child: Image.network(
        'https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332_1280.jpg',
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image.asset(
              'assets/images/tawfeer.png',
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  Widget _titlePriceColumn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Pepsi can 330 ML',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            '\$16.0',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionText(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(width: 20.0),
        Expanded(
          child: Text(
            "I've been trying to customize Flutter SearchDelegate to the type of search field I want it to be. It got a method named appBarTheme with return type ThemeData. Usually using ThemeData you can change the appbar theme but it's not making any change in my case. I am able to customize the hint text style searchFieldStyle method but nothing more.I've been trying to customize Flutter SearchDelegate to the type of search field I want it to be. It got a method named appBarTheme with return type ThemeData. Usually using ThemeData you can change the appbar theme but it's not making any change in my case. I am able to customize the hint text style searchFieldStyle method but nothing more.",
          ),
        ),
        SizedBox(width: 20.0),
      ],
    );
  }

  void _showMenu(BuildContext context) {
    showMenu<int>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      position: const RelativeRect.fromLTRB(20.0, 0.0, 0.0, 0.0),
      items: [
        _popMenuItem(context, 'Edit', 0, Icons.edit, Colors.black),
        _popMenuItem(context, 'Delete', 1, Icons.delete_rounded, MyColors.red),
      ],
    ).then(
      (int? value) {
        // TODO.
      },
    );
  }

  Widget _detailsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          _keysColumn(context),
          const SizedBox(width: 15),
          Expanded(
            child: _valuesColumn(context),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _keysColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Category:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        SizedBox(height: 16),
        Text(
          'OldPrice:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        SizedBox(height: 16),
        Text(
          'Discount:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        SizedBox(height: 16),
        Text(
          'Expire Date:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        SizedBox(height: 16),
        Text(
          'Views:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        SizedBox(height: 16),
        Text(
          'Owner Email:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
      ],
    );
  }

  Widget _valuesColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Drinks',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        Text(
          '\$22.00',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        Text(
          '30%',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        Text(
          'Dec 10, 2021',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        Text(
          '223',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Text(
            'ahmad.alshahal2@gmail.com',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<int> _popMenuItem(
    BuildContext context,
    String text,
    int value,
    IconData icon,
    Color color,
  ) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
