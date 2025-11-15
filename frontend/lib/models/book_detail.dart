class BookDetail {
  final int id;
  final String title;
  final String? alternativeTitle;
  final List<dynamic> authors;
  final List<dynamic> subjects;
  final List<dynamic> bookshelves;
  final Map<String, dynamic> formats;
  final int? downloadCount;
  final DateTime? issued;
  final String? summary;
  final double? readingEaseScore;
  final String? coverImage;
  final bool? removedFromCatalog;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BookDetail({
    required this.id,
    required this.title,
    this.alternativeTitle,
    this.authors = const [],
    this.subjects = const [],
    this.bookshelves = const [],
    this.formats = const {},
    this.downloadCount,
    this.issued,
    this.summary,
    this.readingEaseScore,
    this.coverImage,
    this.removedFromCatalog,
    this.createdAt,
    this.updatedAt,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) {
    return BookDetail(
      id: int.parse(json['id'].toString()),
      title: json['title']!.toString().trim(),
      alternativeTitle: json['alternative_title']?.toString(),
      authors: json['authors'] ?? [],
      subjects: json['subjects'] ?? [],
      bookshelves: json['bookshelves'] ?? [],
      formats: json['formats'] ?? {},
      downloadCount: json['download_count']?.toInt(),
      issued: json['issued'] != null ? DateTime.parse(json['issued'].toString()) : null,
      summary: json['summary']?.toString(),
      readingEaseScore: json['reading_ease_score']?.toDouble(),
      coverImage: json['cover_image']?.toString(),
      removedFromCatalog: json['removed_from_catalog'] != null ? (json['removed_from_catalog'].toString().toLowerCase() == 'true') : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'].toString()) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : null,
    );
  }
}