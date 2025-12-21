import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.poppins(color: Theme.of(context).appBarTheme.backgroundColor),
      decoration: InputDecoration(
        hintText: 'Search books...',
        hintStyle: GoogleFonts.poppins(color: Theme.of(context).appBarTheme.foregroundColor),
        prefixIcon: Icon(Icons.search, color: Theme.of(context).appBarTheme.foregroundColor),
        filled: true,
        fillColor: Theme.of(context).focusColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}