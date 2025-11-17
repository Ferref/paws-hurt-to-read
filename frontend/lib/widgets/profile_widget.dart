import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 24))),
    );
  }
}