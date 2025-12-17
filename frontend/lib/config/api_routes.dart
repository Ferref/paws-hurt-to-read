import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  ApiRoutes._();

  static final String basePath = dotenv.env['API_HOST']!;

  static final String registration = "api/auth/register";
  static final String login = "api/auth/login";
  static final String logout = "api/auth/logout";

  static final String bookDetails = "api/books/{id}";
  static final String bookCovers = "api/books/range/{range}";

  // TODO: implement endpoint for this route (this is a placeholder)
  static final String  userBooks = "api/users/{userId}/books";
}