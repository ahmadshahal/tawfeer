import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(
          fontSize: 17.0,
          color: MyColors.darkBlue,
        ),
      ),
    );
  }
}
