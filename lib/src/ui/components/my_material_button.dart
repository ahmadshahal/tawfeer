import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/themes/styles/styles.dart';

class MyMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback callBack;
  final Color color;

  const MyMaterialButton({
    Key? key,
    required this.text,
    required this.callBack,
    this.color = MyColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyStyles.radius),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        color: color,
        onPressed: callBack,
        child: Text(
          text,
          style: const TextStyle(
            color: MyColors.white,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
