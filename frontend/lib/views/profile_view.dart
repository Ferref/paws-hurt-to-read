import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.deepPurple,
            child: const Center(
              child: FaIcon(
                Icons.admin_panel_settings_sharp,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ExampleUser",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "exampleuser@email.com",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white70,
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
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
                child: const Text("Change Password"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}