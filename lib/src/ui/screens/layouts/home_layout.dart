import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/home_layout_cubit/home_layout_cubit.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/ui/components/my_drawer.dart';
import 'package:tawfeer/src/ui/components/products_list_item.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          if (state is HomeLayoutLoading) {
            return _loading(context);
          } else if (state is HomeLayoutFailure) {
            return _failure(context);
          }
          if((state as HomeLayoutSuccess).list.isEmpty) {
            return _successEmptyList(context);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  _listView(context, state.list),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: _floatingActionButton(context),
      drawer: const MyDrawer(),
    );
  }

  Widget _loading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _successEmptyList(BuildContext context) {
    return const Center(
      child: Text(
        'Empty List',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _failure(BuildContext context) {
    return const Center(
      child: Text(
        'Something went wrong',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 2.0,
      backgroundColor: MyColors.secondaryColor,
      title: const Text(
        'Tawfeer',
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
}
