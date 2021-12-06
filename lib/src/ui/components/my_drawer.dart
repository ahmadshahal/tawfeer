import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ScrollConfiguration(
        behavior: NonGlowScrollBehavior(),
        child: ListView(
          children: [
            SizedBox(
              height: 218,
              child: DrawerHeader(
                margin: const EdgeInsets.only(top: 20),
                child: _userDateColumn(context),
              ),
            ),
            ListTile(
              title: const Text('My Products'),
              onTap: () {
                // TODO
              },
              leading: const Icon(
                Icons.format_list_bulleted_rounded,
                color: MyColors.primaryColor,
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // TODO
              },
              leading: const Icon(
                Icons.logout,
                color: MyColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userDateColumn(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
            'https://scontent.flca1-1.fna.fbcdn.net/v/t1.6435-9/66344627_1304933179673247_145168880992518144_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=orZ-ALdojNoAX_I8gpt&_nc_ht=scontent.flca1-1.fna&oh=3e36c5d41417eb3f54b7e31c7e8eb1cc&oe=61D42B5A',
          ),
          backgroundColor: MyColors.lightGrey,
        ),
        SizedBox(height: 15),
        Text(
          'Ahmad Al-Shahal',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 5),
        Text(
          'ahmad.alshahal2@gmail.com',
          style: TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
