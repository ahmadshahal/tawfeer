import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/home_nav_cubit/home_nav_cubit.dart';
import 'package:tawfeer/src/ui/screens/modules/products_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/profile_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/search_screen.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  final List<Widget> screens = [
    const ProductsScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  final List<String> titles = [
    'Products',
    'Search',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavCubit, HomeNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context, state),
          body: screens[state.index],
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
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            onTap: (int index) {
              BlocProvider.of<HomeNavCubit>(context).changeIndex(index: index);
            },
            selectedFontSize: 12,
            elevation: 6.0,
            currentIndex: state.index,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, HomeNavState state) {
    return AppBar(
      elevation: 2.0,
      // centerTitle: true,
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      title: Text(
        titles[state.index],
        style: const TextStyle(
          fontSize: 16.0,
          color: MyColors.darkBlue,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset('assets/images/tawfeer.png'),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: const Icon(
            Icons.more_vert,
            color: MyColors.darkBlue,
          ),
          splashRadius: 18.0,
        ),
      ],
    );
  }
}
