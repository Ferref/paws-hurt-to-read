import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  ApiRoutes._();

  static final String basePath = dotenv.env['API_HOST']!;

  static final String registration = "api/auth/register";
  static final String registrationEmail = "api/auth/users/email/{user}";

  static final String login = "api/auth/login";
  static final String logout = "api/auth/logout";
  static final String refresh = "api/auth/refresh";

  static final String bookDetails = "api/books/{id}";
  static final String bookCovers = "api/books/range/{range}";

  static final String  userBooks = "api/users/{user}/books/{book}";
}