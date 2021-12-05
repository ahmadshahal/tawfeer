import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/home_nav_cubit/home_nav_cubit.dart';
import 'package:tawfeer/src/ui/components/my_drawer.dart';
import 'package:tawfeer/src/ui/screens/modules/products_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/search_screen.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  final List<Widget> screens = [
    const ProductsScreen(),
    const SearchScreen(),
  ];

  final List<String> titles = [
    'Products',
    'Search',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavCubit, HomeNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context, state),
          body: screens[state.index],
          floatingActionButton: _floatingActionButton(context),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted_outlined),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
            onTap: (int index) {
              BlocProvider.of<HomeNavCubit>(context).changeIndex(index: index);
            },
            selectedFontSize: 12,
            elevation: 15.0,
            currentIndex: state.index,
          ),
          drawer: const MyDrawer(),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, HomeNavState state) {
    return AppBar(
      elevation: 2.0,
      backgroundColor: MyColors.secondaryColor,
      title: Text(
        titles[state.index],
        style: const TextStyle(
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
