import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.secondaryColor,
        ),
      ),
    );
  }
}
