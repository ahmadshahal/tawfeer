import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/add_product_cubit/add_product_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/delete_product_cubit/delete_product_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/expire_date_field_cubit/expire_date_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/home_layout_cubit/home_layout_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/login_cubit/login_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/my_products_cubit/my_products_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/product_cubit/product_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/register_cubit/register_cubit.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/ui/screens/layouts/home_layout.dart';
import 'package:tawfeer/src/ui/screens/modules/add_product_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/edit_product_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/login_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/my_products_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/product_screen.dart';
import 'package:tawfeer/src/ui/screens/modules/register_screen.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/utility.dart';

import 'business_logic/bloc/cubits/edit_product_cubit/edit_product_cubit.dart';
import 'business_logic/bloc/cubits/image_picker_cubit/image_picker_cubit.dart';
import 'business_logic/models/product.dart';

void main() async {
  // You only need to call this method if you need the binding to be
  // initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Reconsider.
  Shared.pref = await SharedPreferences.getInstance();
  // Shared.pref.remove('token');
  Shared.token = Shared.pref.get('token') as String?;
  if (Shared.token != null) {
    try {
      await UserRepository.validateToken(Shared.token!);
      Shared.myUser = await UserRepository().profile();
    } catch (e) {
      if (e.toString() == "Exception: Unauthenticated.") {
        Shared.token = null;
        Shared.pref.remove('token');
      }
      else {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }
  }
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
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 16,
          ), // Used for the custom search delegate appbar.
        ),
        fontFamily: 'Saira',
      ),
      home: Shared.token == null
          ? BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginScreen(),
            )
          : BlocProvider(
              create: (context) => HomeLayoutCubit()..fetchData(),
              child: HomeLayout(),
            ),
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
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
                BlocProvider(
                  create: (context) => ExpireDateCubit(),
                ),
                BlocProvider(
                  create: (context) => AddProductCubit(),
                ),
                BlocProvider(
                  create: (context) => ImagePickerCubit(),
                ),
              ],
              child: AddProductScreen(),
            );
          },
          '/edit_product': (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => EditProductCubit(),
                ),
                BlocProvider(
                  create: (context) => ImagePickerCubit(),
                ),
              ],
              child: EditProductScreen(product: settings.arguments as Product),
            );
          },
          '/product': (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      ProductCubit()..fetchData(id: settings.arguments as int),
                ),
                BlocProvider(
                  create: (context) => DeleteProductCubit(),
                ),
              ],
              child: ProductScreen(id: settings.arguments as int),
            );
          }
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }
}
