import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.deepPurpleAccent,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.shieldCat,
                  color: Theme.of(context).canvasColor,
                  size: 100,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ExampleUser",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "exampleuser@email.com",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Change Email"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Change Password"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}