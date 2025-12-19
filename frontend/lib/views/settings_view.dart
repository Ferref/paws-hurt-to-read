import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/views/settings/theme_view.dart';

// TODO: display settings
// TODO: setting change implementation
// TODO: dark mode, light mode and color picker

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThemeView()),
            );
          },
          child: ListTile(
            title: Text(
              "Theme",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            leading: Icon(Icons.color_lens),
          ),
        ),
      ],
    );
  }
}
