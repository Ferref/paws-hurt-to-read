import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    super.key,
    required this.context,
    required this.text,
  });

  final BuildContext context;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: Theme.of(context).appBarTheme.foregroundColor, fontSize: 26),
    );
  }
}
