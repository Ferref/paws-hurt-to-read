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
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text('PawsHurtToRead', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.black),
            title: const Text('Profile', style: TextStyle(color: Colors.black)),
            onTap: () {
              if (onItemTap != null) onItemTap!('Profile');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics, color: Colors.black),
            title: const Text('Analytics', style: TextStyle(color: Colors.black)),
            onTap: () {
              if (onItemTap != null) onItemTap!('Analytics');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.black),
            title: const Text('Settings', style: TextStyle(color: Colors.black)),
            onTap: () {
              if (onItemTap != null) onItemTap!('Settings');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}