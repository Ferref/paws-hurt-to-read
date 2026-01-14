import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';

class UserBookHandler {
  final EpubController epubController = EpubController();

  Future<bool> isBookOnDevice(int bookId) async {
    final file = File('/storage/emulated/0/Download/epubs/$bookId.epub');
    return file.exists();
  }

  Future<bool> deleteBookFromDevice(int bookId) async {
    final filePath = '/storage/emulated/0/Download/epubs/$bookId.epub';
    final file = File(filePath);

    if (await file.exists()) {
      throw Exception("File not on device");
    }

    await file.delete();
    return true;
  }

  void openBook(BuildContext context, int bookId) {
    final filePath = '/storage/emulated/0/Download/epubs/$bookId.epub';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.white,
          body: EpubViewer(
            epubController: epubController,
            epubSource: EpubSource.fromFile(File(filePath)),
          ),
        ),
      ),
    );
  }
}
