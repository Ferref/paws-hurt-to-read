import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: display profile data
// TODO: profile data change implementation

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 24))),
    );
  }
}
