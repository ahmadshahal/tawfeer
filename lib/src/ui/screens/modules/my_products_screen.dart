import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/my_products_cubit/my_products_cubit.dart';
import 'package:tawfeer/src/ui/components/loading.dart';
import 'package:tawfeer/src/ui/components/my_list_view.dart';
import 'package:tawfeer/src/ui/components/user_msg.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<MyProductsCubit>(context).fetchData(),
          child: BlocBuilder<MyProductsCubit, MyProductsState>(
            builder: (context, state) {
              if (state is MyProductsInitial) {
                return const Loading();
              }
              if (state is MyProductsFailure) {
                return const UserMsg(
                  text: 'Something went wrong, swipe to refresh.',
                  imgUrl: 'assets/images/error404.png',
                );
              }
              if ((state as MyProductsSuccess).list.isEmpty) {
                return const UserMsg(
                  text: 'No products for now, swipe to refresh',
                  imgUrl: 'assets/images/no_items.png',
                );
              }
              return SizedBox(
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
                      MyListView(list: state.list),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
    );
  }
}
