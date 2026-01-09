class User {
  final String id;
  final String name;
  final String email;
  String accessToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      accessToken: json['access_token'] as String,
    );
  }
}