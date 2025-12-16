import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: display settings
// TODO: setting change implementation
// TODO: dark mode, light mode and color picker

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 24))),
    );
  }
}
