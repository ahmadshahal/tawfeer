import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class UserMsg extends StatelessWidget {
  const UserMsg({Key? key, required this.text, required this.imgUrl, required this.onRefresh}) : super(key: key);

  final String text;
  final String imgUrl;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Center(
        child: ScrollConfiguration(
          behavior: NonGlowScrollBehavior(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imgUrl,
                  height: 350,
                  width: 350,
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
