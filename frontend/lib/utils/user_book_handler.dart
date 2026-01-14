import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserBookHandler {
  Future<bool> isBookOnDevice(int bookId) async {
    final file = File('/storage/emulated/0/Download/epubs/$bookId.epub');
    return file.exists();
  }
}
