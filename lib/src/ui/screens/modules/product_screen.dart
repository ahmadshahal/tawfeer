import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/components/loading.dart';
import 'package:tawfeer/src/ui/components/user_msg.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To avoid overflow when showing the screen while
      // the keyboard isn't closed.
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: Builder(
        builder: (context) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return BlocProvider.of<ProductCubit>(context).fetchData();
            },
            edgeOffset: Scaffold.of(context).appBarMaxHeight ?? 50,
            displacement: 30,
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: Scaffold.of(context).appBarMaxHeight ?? 80,
                    ),
                    child: const Loading(),
                  );
                }
                if (state is ProductFailure) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: Scaffold.of(context).appBarMaxHeight ?? 80,
                    ),
                    child: const UserMsg(
                      text: 'Something went wrong, swipe to refresh.',
                      imgUrl: 'assets/images/error404.png',
                    ),
                  );
                }
                return ScrollConfiguration(
                  behavior: NonGlowScrollBehavior(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      // So I can add a SingleChildScrollView even though I have an
                      // Expanded widget.
                      height: MediaQuery.of(context).size.height,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _productImage(
                              context,
                              (state as ProductSuccess).product,
                            ),
                            const SizedBox(height: 20),
                            _titlePriceColumn(context, state.product),
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
                                    // TODO: Make it scrollable.
                                    _detailsRow(
                                      context,
                                      state.product,
                                      state.ownerEmail,
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 16),
                                          _descriptionText(
                                            context,
                                            state.product,
                                          ),
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
                    ),
                  ),
                );
              },
            ),
          );
        },
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

  Widget _productImage(BuildContext context, Product product) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      width: double.infinity,
      color: MyColors.white,
      child: Image.network(
        product.imgUrl,
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

  Widget _titlePriceColumn(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productTitle,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            "\$${product.newPrice.toString()}",
            style: const TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionText(BuildContext context, Product product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 20.0),
        Expanded(
          child: Text(product.description),
        ),
        const SizedBox(width: 20.0),
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

  Widget _detailsRow(BuildContext context, Product product, String ownerEmail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          _keysColumn(context),
          const SizedBox(width: 15),
          Expanded(
            child: _valuesColumn(context, product, ownerEmail),
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
          'Quantity:',
          style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
        ),
        SizedBox(height: 16),
        Text(
          'Old Price:',
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

  Widget _valuesColumn(
    BuildContext context,
    Product product,
    String ownerEmail,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.category,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          product.quantity.toString(),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          "\$${product.oldPrice.toString()}",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          // TODO: Get it from backend.
          "${product.quantity.toString()}%",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          DateFormat.yMMMd().format(product.expireDate),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Text(
          product.seens.toString(),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Text(
            ownerEmail,
            style: const TextStyle(fontSize: 14),
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