import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoiceWidget extends StatefulWidget {
  final String title;
  final String message;

  const ChoiceWidget({
    super.key,
    required this.title,
    required this.message
  });

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.poppins();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 200, horizontal: 10),
      child: AlertDialog(
        title: Center(child: Text(widget.title, style: textStyle)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: textStyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
          ],
        ),
        actionsPadding: const EdgeInsets.all(10),
        actions: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () => developer.log('Open Book'),
                  icon: const Icon(FontAwesomeIcons.bookOpen),
                  label: const Text(
                    'Open book',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 4),
                TextButton.icon(
                  onPressed: () => developer.log('Remove from device'),
                  icon: const Icon(FontAwesomeIcons.trash),
                  label: const Text('Remove from device'),
                ),
                const SizedBox(height: 2),
                TextButton.icon(
                  onPressed: () => developer.log(
                    'Remove from device, delete from my account',
                  ),
                  icon: const Icon(FontAwesomeIcons.userSlash),
                  label: const Text('Remove from account'),
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(FontAwesomeIcons.xmark),
                  label: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
