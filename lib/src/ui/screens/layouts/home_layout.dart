import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/home_layout_cubit/home_layout_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/logout_cubit/logout_cubit.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/ui/components/loading.dart';
import 'package:tawfeer/src/ui/components/my_drawer.dart';
import 'package:tawfeer/src/ui/components/my_list_view.dart';
import 'package:tawfeer/src/ui/components/user_msg.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/components/custom_search_delegate.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key) {
    Shared.homeRefreshIndicatorKey = _refreshIndicatorKey;
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () =>
              BlocProvider.of<HomeLayoutCubit>(context).fetchData(),
          child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
            builder: (context, state) {
              if (state is HomeLayoutInitial) {
                return const Loading();
              }
              if (state is HomeLayoutFailure) {
                return UserMsg(
                  text: state.exception.message + ', swipe to refresh..',
                  imgUrl: 'assets/images/error404.png',
                );
              }
              if ((state as HomeLayoutSuccess).list.isEmpty) {
                return const UserMsg(
                  text: 'No products for now, swipe to refresh..',
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
      floatingActionButton: _floatingActionButton(context),
      drawer: BlocProvider(
        create: (context) => LogoutCubit(),
        child: const MyDrawer(),
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
      // The Builder widget is used to create a new context, that is the
      // Scaffold's context, not the context that is sent to the HomeLayout
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
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(
                products: BlocProvider.of<HomeLayoutCubit>(context).list,
              ),
            );
          },
          icon: const Icon(
            Icons.search_rounded,
            color: MyColors.white,
          ),
          splashRadius: 20.0,
        ),
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

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/add_product').then(
          (dynamic value) {
            if (value == true) {
              _refreshIndicatorKey.currentState?.show();
            }
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }

  void _showMenu(BuildContext context) {
    HomeLayoutCubit cubit = BlocProvider.of<HomeLayoutCubit>(context);
    showMenu<int>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      position: const RelativeRect.fromLTRB(20.0, 0.0, 0.0, 0.0),
      items: [
        _popMenuItem(context, 'Sort by price', 0, cubit),
        _popMenuItem(context, 'Sort by views', 1, cubit),
        _popMenuItem(context, 'Sort by date', 2, cubit),
      ],
    ).then(
      (int? value) {
        if (value == null) return;
        cubit.updateSortIndex(sortIndex: value);
      },
    );
  }

  PopupMenuItem<int> _popMenuItem(
      BuildContext context, String text, int value, HomeLayoutCubit cubit) {
    return PopupMenuItem<int>(
      value: value,
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: value,
            groupValue: cubit.sortIndex,
            onChanged: (_) {
              Navigator.pop(context);
              cubit.updateSortIndex(sortIndex: value);
            },
            splashRadius: 0.1,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
