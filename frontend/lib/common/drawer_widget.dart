import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
            padding: EdgeInsetsGeometry.all(40),
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.paw,
                  size: 50,
                  shadows: <Shadow>[
                    Shadow(color: Theme.of(context).cardColor, blurRadius: 15.0),
                  ],
                ),
              ],
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
