import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserBookHandler {
  
  Future<bool> isBookOnDevice(int bookId) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/books/$bookId.epub');
    return file.exists();
  }

}