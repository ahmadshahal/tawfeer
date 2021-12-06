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
            return _userMsg(context, Icons.warning_rounded, 'Something went wrong..', 'Try Again');
          }
          if ((state as HomeLayoutSuccess).list.isEmpty) {
            return _userMsg(context, Icons.list_rounded, 'No products for now..', 'Refresh');
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RefreshIndicator(
              strokeWidth: 2.0,
              onRefresh: () {
                return BlocProvider.of<HomeLayoutCubit>(context).fetchData();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
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
      floatingActionButton: _floatingActionButton(context),
      drawer: const MyDrawer(),
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
        'Tawfeer',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.white,
        ),
      ),
      // The Builder widget is used to create a new context, that is the
      // Scaffold's, context, not the context that is sent to the HomeLayout
      // widget. Check the implementation of the Builder widget for more.
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu_rounded),
          splashRadius: 20.0,
        );
      }),
      actions: [
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: const Icon(
            Icons.search_rounded,
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

  Widget _userMsg(BuildContext context, IconData icon, String text, String buttonText) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: MyColors.secondaryColor,
          ),
          const SizedBox(height: 20.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 19,
              color: MyColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 37.0),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: MaterialButton(
              onPressed: () {
                BlocProvider.of<HomeLayoutCubit>(context).fetchData();
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: MyColors.white,
                  fontSize: 14,
                ),
              ),
              color: MyColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
