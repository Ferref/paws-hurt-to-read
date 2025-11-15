import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Analytics Screen', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 24))),
    );
  }
}