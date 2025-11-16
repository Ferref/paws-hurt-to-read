import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 24))),
    );
  }
}
