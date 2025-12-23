import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:frontend/views/settings/theme/theme_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Theme.of(context).canvasColor,
      child: ListTile(
        leading: const Icon(FontAwesomeIcons.paintbrush),
        title: Text(
          "Theme",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Theme.of(context).navigationBarTheme.backgroundColor,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThemeView()),
        ),
      ),
    );
  }
}
