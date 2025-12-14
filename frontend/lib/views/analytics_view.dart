import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Analytics', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 24))),
    );
  }
}
