import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/images/tawfeer.png',
            ),
          ),
          ListTile(
            title: const Text('My Products'),
            onTap: () {
              // TODO
            },
            leading: const Icon(Icons.format_list_bulleted_outlined),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // TODO
            },
            leading: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
