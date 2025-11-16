import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'My Books Screen',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
        fontSize: 24,
        color: Colors.white,
          ),
        ),
      ),
    );
  }
}