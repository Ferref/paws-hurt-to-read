import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerWidget(onItemTap: null);
  }
}

class DrawerWidget extends StatelessWidget {
  final ValueChanged<String>? onItemTap;

  const DrawerWidget({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'PawsHurtToRead',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
            onTap: () {
              if (onItemTap != null) {
                onItemTap!('Profile');
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.analytics,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            title: Text(
              'Analytics',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
            onTap: () {
              if (onItemTap != null) {
                onItemTap!('Analytics');
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
            onTap: () {
              if (onItemTap != null) {
                onItemTap!('Settings');
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
            onTap: () {
              if (onItemTap != null) {
                onItemTap!('Logout');
              }
            },
          ),
        ],
      ),
    );
  }
}
