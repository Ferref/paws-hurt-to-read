import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/user_book_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:frontend/main.dart';

class ChoiceWidget extends StatefulWidget {
  final String title;
  final String message;
  final AuthService _authService = getIt<AuthService>();
  final UserBookHandler _userBookHandler = getIt<UserBookHandler>();

  int bookId;

  ChoiceWidget({
    super.key,
    required this.title,
    required this.message,
    required this.bookId,
  });

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  bool _loading = false;

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
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() => _loading = true);

                          try {
                            bool bookOnDevice = await widget._userBookHandler
                                .isBookOnDevice(widget.bookId);
                            developer.log(bookOnDevice.toString());

                            if (!bookOnDevice) {
                              await widget._authService.downloadEpub(
                                bookId: widget.bookId,
                              );
                            }

                            if (!context.mounted) {
                              return;
                            }

                            widget._userBookHandler.openBook(
                              context,
                              widget.bookId,
                            );
                          } catch (e) {

                            if (!context.mounted) {
                              return;
                            }

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString().replaceFirst('Exception: ', ''),
                                ),
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() => _loading = false);
                            }
                          }
                        },
                  icon: _loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(FontAwesomeIcons.bookOpen),
                  label: Text(
                    _loading ? 'Downloading book' : 'Open book',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),

                const SizedBox(height: 4),
                TextButton.icon(
                  onPressed: () async {
                    try {
                      bool deleted = await widget._userBookHandler
                          .deleteBookFromDevice(widget.bookId);

                      if (deleted) {
                        if (!context.mounted) {
                          return;
                        }

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Book deleted from device...'),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to delete book from device...'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.trash),
                  label: const Text('Remove from device'),
                ),
                const SizedBox(height: 2),
                TextButton.icon(
                  onPressed: () async {
                    try {
                      await widget._authService.deleteBook(widget.bookId);

                      if (!context.mounted) {
                        return;
                      }

                      Navigator.pop(context, true);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Book removed from you account...'),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Could not delete book, please try again later...',
                          ),
                        ),
                      );
                    }
                  },
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
