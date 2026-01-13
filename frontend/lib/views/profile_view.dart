import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService _authService = getIt<AuthService>();

  Future<void> _changeEmail(
    BuildContext context,
    String oldEmail,
    String newEmail,
  ) async {
    try {
      await _authService.changeEmail(
        oldEmail: oldEmail,
        newEmail: newEmail,
      );

      if (!mounted) {
        return;
      }

      setState(() {});

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email updated successfully'),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
        ),
      );
    }
  }

  void _showChangeEmailDialog(BuildContext context) {
    final oldEmailController = TextEditingController();
    final newEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Change Email'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldEmailController,
              decoration: const InputDecoration(labelText: 'Old Email'),
            ),
            TextField(
              controller: newEmailController,
              decoration: const InputDecoration(labelText: 'New Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _changeEmail(
                context,
                oldEmailController.text,
                newEmailController.text,
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Change Password',
          style: GoogleFonts.poppins(fontSize: 24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Old Password'),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

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
                  shadows: [
                    Shadow(
                      color: Theme.of(context).highlightColor,
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _authService.user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      color: Theme.of(context)
                          .appBarTheme
                          .foregroundColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _authService.user.email,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Theme.of(context)
                          .appBarTheme
                          .foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showChangeEmailDialog(context);
                  },
                  child: const Text('Change Email'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _showChangePasswordDialog(context);
                  },
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}