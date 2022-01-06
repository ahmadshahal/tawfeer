import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.icon,
    required this.counter,
    required this.iconColor,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final int counter;
  final GestureTapCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: MyColors.lightGrey,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
          ),
        ),
        CircleAvatar(
          child: Text(
            '$counter',
            style: const TextStyle(
              fontSize: 9,
              color: MyColors.darkGrey,
            ),
          ),
          radius: 9,
          backgroundColor: MyColors.white,
        ),
      ],
    );
  }
}
