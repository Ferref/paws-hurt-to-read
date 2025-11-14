class Book {
  final int? id;
  final String title;
  final String coverImage;

  Book({this.id, required this.title, required this.coverImage});

  factory Book.fromJson(Map<String, dynamic> json) {
    int? parseInt(dynamic value) {
      if (value == null) {
        return null;
      }

      if (value is int) {
        return value;
      }
      return int.tryParse(value.toString());
    }

    final int? id = parseInt(json['id']);
    final String title = (json['title']?.toString() ?? 'Untitled').trim();
    final String coverImage = json['cover_image']?.toString() ?? '';

    return Book(id: id, title: title, coverImage: coverImage);
  }
}
