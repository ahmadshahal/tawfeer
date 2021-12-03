import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/screens/modules/login_screen.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/utility.dart';

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
      home: const LoginScreen(),
    );
  }
}
