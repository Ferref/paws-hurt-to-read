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
    DateTime? parseDate(Object? v) {
      if (v == null)return null;
      if (v is DateTime) return v;
      return DateTime.tryParse(v.toString());
    }

    return BookDetail(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: json['title']?.toString() ?? '',
      alternativeTitle: json['alternative_title']?.toString(),
      authors: json['authors'] != null ? List<dynamic>.from(json['authors']) : [],
      subjects: json['subjects'] != null ? List<dynamic>.from(json['subjects']) : [],
      bookshelves: json['bookshelves'] != null ? List<dynamic>.from(json['bookshelves']) : [],
      formats: json['formats'] != null ? Map<String, dynamic>.from(json['formats']) : {},
      downloadCount: json['download_count'] != null ? (json['download_count'] as num).toInt() : null,
      issued: parseDate(json['issued']),
      summary: json['summary']?.toString(),
      readingEaseScore: json['reading_ease_score'] != null ? (json['reading_ease_score'] as num).toDouble() : null,
      coverImage: json['cover_image']?.toString(),
      removedFromCatalog: json['removed_from_catalog'] == null ? false : (json['removed_from_catalog'] == true),
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'alternative_title': alternativeTitle,
        'authors': authors,
        'subjects': subjects,
        'bookshelves': bookshelves,
        'formats': formats,
        'download_count': downloadCount,
        'issued': issued?.toIso8601String(),
        'summary': summary,
        'reading_ease_score': readingEaseScore,
        'cover_image': coverImage,
        'removed_from_catalog': removedFromCatalog,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}