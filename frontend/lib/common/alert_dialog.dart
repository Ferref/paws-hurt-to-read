import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertWidget extends StatefulWidget {
  final String title;
  final String message;
  final Icon icon;

  const AlertWidget({super.key, required this.title, required this.message, required this.icon});

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 10),
      child: AlertDialog(
        title: Center(child: Text(widget.title, style: GoogleFonts.poppins())),
        content: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.message, style: GoogleFonts.poppins(fontSize: 18)),
                widget.icon
              ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
