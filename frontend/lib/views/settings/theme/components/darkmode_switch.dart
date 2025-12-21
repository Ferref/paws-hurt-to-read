import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkmodeSwitch extends StatefulWidget {
  const DarkmodeSwitch({super.key});

  @override
  State<DarkmodeSwitch> createState() => _DarkmodeSwitchState();
}

class _DarkmodeSwitchState extends State<DarkmodeSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Dark mode",
              style: GoogleFonts.poppins(fontSize: 24, color: Theme.of(context).navigationBarTheme.shadowColor),
            ),
            Switch(
              value: AdaptiveTheme.of(context).mode.isDark,
              activeThumbColor: Colors.deepPurpleAccent,
              onChanged: (bool value) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
