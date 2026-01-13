import 'dart:convert';

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

  void _showChangeEmailDialog(BuildContext context) {
    final oldEmailController = TextEditingController();
    final newEmailController = TextEditingController();

    String? oldEmailError;
    String? newEmailError;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> submit() async {
              setDialogState(() {
                oldEmailError = null;
                newEmailError = null;
              });

              try {
                await _authService.changeEmail(
                  oldEmail: oldEmailController.text,
                  newEmail: newEmailController.text,
                );

                if (!mounted) {
                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email updated successfully'),
                  ),
                );
              } catch (e) {
                try {
                  final decoded = jsonDecode(
                    e.toString().replaceFirst('Exception: ', ''),
                  );

                  setDialogState(() {
                    if (decoded['errors'] != null) {
                      if (decoded['errors']['old_email'] != null) {
                        oldEmailError =
                            decoded['errors']['old_email'][0];
                      }
                      if (decoded['errors']['new_email'] != null) {
                        newEmailError =
                            decoded['errors']['new_email'][0];
                      }
                      if (decoded['errors']['email'] != null) {
                        if (oldEmailError == null) {
                          oldEmailError =
                              decoded['errors']['email'][0];
                        }
                        if (newEmailError == null) {
                          newEmailError =
                              decoded['errors']['email'][0];
                        }
                      }
                    }
                  });
                } catch (_) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Email update failed. Please try again later',
                        ),
                      ),
                    );
                  }
                }
              }
            }

            return AlertDialog(
              title: const Text('Change Email'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: oldEmailController,
                    decoration: InputDecoration(
                      labelText: 'Old Email',
                      errorText: oldEmailError,
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: newEmailController,
                    decoration: InputDecoration(
                      labelText: 'New Email',
                      errorText: newEmailError,
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
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
                  onPressed: submit,
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final newPasswordConfirmationController = TextEditingController();

    String? oldPasswordError;
    String? newPasswordError;
    String? confirmationError;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> submit() async {
              setDialogState(() {
                oldPasswordError = null;
                newPasswordError = null;
                confirmationError = null;
              });

              // await _authService.changePassword(
              //   oldPassword: oldPasswordController.text,
              //   newPassword: newPasswordController.text,
              //   newPasswordConfirmation:
              //       newPasswordConfirmationController.text,
              // );
            }

            return AlertDialog(
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
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      errorText: oldPasswordError,
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      errorText: newPasswordError,
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: newPasswordConfirmationController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password Confirmation',
                      errorText: confirmationError,
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
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
                  onPressed: submit,
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
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
