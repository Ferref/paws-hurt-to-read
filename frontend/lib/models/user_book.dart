import 'package:frontend/models/book.dart';

class UserBook {
  final Book book;
  final String cfi;

  UserBook({required this.book, required this.cfi});

  factory UserBook.fromJson(Map<String, dynamic> json) {
    return UserBook(
      cfi: (json['cfi'] ?? '').toString(),
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
    );
  }
}
