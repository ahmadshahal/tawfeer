import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/my_products_cubit/my_products_cubit.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/components/products_list_item.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<MyProductsCubit, MyProductsState>(
          builder: (context, state) {
            if (state is MyProductsLoading) {
              return _loading(context);
            } else if (state is MyProductsFailure) {
              return _failure(context);
            }
            if ((state as MyProductsSuccess).list.isEmpty) {
              return _emptyList(context);
            }
            return RefreshIndicator(
              strokeWidth: 2.0,
              onRefresh: () {
                return BlocProvider.of<MyProductsCubit>(context).fetchData();
              },
              child: SizedBox(
                // To make the single child scroll view go to the end
                // without something clipped when scrolling.
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 15.0),
                      _listView(context, state.list),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _failure(BuildContext context) {
    return RefreshIndicator(
      child: _userMsg(
        context,
        'assets/images/error404.png',
        'Something went wrong, swipe to refresh.',
      ),
      onRefresh: () {
        return BlocProvider.of<MyProductsCubit>(context).fetchData();
      },
    );
  }

  Widget _emptyList(BuildContext context) {
    return RefreshIndicator(
      child: _userMsg(
        context,
        'assets/images/no_items.png',
        'No products for now, swipe to refresh.',
      ),
      onRefresh: () {
        return BlocProvider.of<MyProductsCubit>(context).fetchData();
      },
    );
  }

  Widget _loading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 2.0,
      backgroundColor: MyColors.secondaryColor,
      title: const Text(
        'My Products',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.white,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: 20.0,
      ),
      actions: [
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

  Widget _listView(BuildContext context, List<Product> list) {
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

  Widget _userMsg(BuildContext context, String imgUrl, String text) {
    return Center(
      child: ScrollConfiguration(
        behavior: NonGlowScrollBehavior(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imgUrl,
                height: 350,
                width: 350,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
