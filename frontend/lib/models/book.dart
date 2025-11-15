class Book {
  final int id;
  final String title;
  final String? coverImage;

  Book({required this.id, required this.title, this.coverImage});

  factory Book.fromJson(Map<String, dynamic> json) {
    final int id = int.parse(json['id'].toString());
    final String title = json['title']!.toString().trim();
    final String? coverImage = json['cover_image']?.toString();

    return Book(id: id, title: title, coverImage: coverImage);
  }
}
