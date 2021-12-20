import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/add_product_cubit/add_product_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/expire_date_field_cubit/expire_date_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/home_layout_cubit/home_layout_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/login_cubit/login_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/my_products_cubit/my_products_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/register_cubit/register_cubit.dart';
import 'package:tawfeer/src/ui/screens/layouts/home_layout.dart';
import 'package:tawfeer/src/ui/screens/modules/add_product_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/login_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/my_products_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/register_screen.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/utility.dart';

import 'business_logic/bloc/cubits/image_picker_cubit/image_picker_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tawfeer',
      theme: ThemeData(
        primarySwatch: Utility.createMaterialColor(
          MyColors.primaryColor,
        ),
        fontFamily: 'Saira',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) {
          return BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          );
        },
        '/register': (context) {
          return BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterScreen(),
          );
        },
        '/home': (context) {
          return BlocProvider(
            create: (context) => HomeLayoutCubit()..fetchData(),
            child: HomeLayout(),
          );
        },
        '/myProducts': (context) {
          return BlocProvider(
            create: (context) => MyProductsCubit()..fetchData(),
            child: const MyProductsScreen(),
          );
        },
        '/add_product': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider (
                create: (context) => ExpireDateCubit(),
              ),
              BlocProvider (
                create: (context) => AddProductCubit(),
              ),
              BlocProvider (
                create: (context) => ImagePickerCubit(),
              ),
            ],
            child: AddProductScreen(),
          );
        },
      },
    );
  }
}
