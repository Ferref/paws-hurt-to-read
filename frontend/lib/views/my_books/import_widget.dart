import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ImportWidget extends StatelessWidget {
  const ImportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (_) => [const FileUploaderWidget()),]
            // );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Import Books',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}