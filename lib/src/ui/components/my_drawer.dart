import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/shared/my_user.dart';
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
                child: _userDataColumn(context),
              ),
            ),
            ListTile(
              title: const Text('My Products'),
              onTap: () {
                Navigator.pushNamed(context, '/myProducts');
              },
              leading: const Icon(
                Icons.format_list_bulleted_rounded,
                color: MyColors.primaryColor,
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                showDialog(context: context, builder: _logoutDialog);
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

  Widget _userDataColumn(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(MyUser.myUser!.imgUrl),
          backgroundColor: MyColors.lightGrey,
        ),
        const SizedBox(height: 15),
        Text(
          MyUser.myUser!.fullName,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 5),
        Text(
          MyUser.myUser!.email,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  AlertDialog _logoutDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      title: const Text('Logout?'),
      content: const Text('You will be returned to the login screen.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // TODO: Delete token.
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
