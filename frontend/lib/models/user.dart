class User {
  final String id;
  final String name;
  final String email;
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['auth_token'] as String,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, token: $token)';
  }
}