import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import 'package:frontend/config/api_routes.dart';
import 'package:frontend/models/user_book.dart';
import 'package:frontend/models/user.dart';

class AuthService {
  final String host = ApiRoutes.basePath;
  final String loginEndpoint = ApiRoutes.login;
  final String logoutEndpoint = ApiRoutes.logout;
  final String refreshEndpoint = ApiRoutes.refresh;
  final String userBooksEndpoint = ApiRoutes.userBooks;
  final String registrationEmailEndpoint = ApiRoutes.registrationEmail;
  final String epubsEndpoint = ApiRoutes.epubs;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  late User user;

  Future<http.Response> _authGet(String endpoint) async {
    final uri = Uri.parse('$host/$endpoint');
    developer.log(uri.toString());
    developer.log(user.id.toString());
    developer.log(user.accessToken.toString());

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
    );

    if (response.statusCode != 401) {
      return response;
    }

    await _refreshAccessToken();

    final retryResponse = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
    );

    if (retryResponse.statusCode == 401) {
      throw Exception('Session expired');
    }

    return retryResponse;
  }

  Future<http.Response> _authDelete(String endpoint) async {
    final uri = Uri.parse('$host/$endpoint');
    developer.log(uri.toString());
    developer.log(user.id.toString());
    developer.log(user.accessToken.toString());

    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
    );

    if (response.statusCode != 401) {
      return response;
    }

    await _refreshAccessToken();

    final retryResponse = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
    );

    if (retryResponse.statusCode == 401) {
      throw Exception('Session expired');
    }

    return retryResponse;
  }

  Future<http.Response> _authPost(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('$host/$endpoint');

    developer.log(user.id.toString());
    developer.log(user.accessToken.toString());

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 401) {
      return response;
    }

    await _refreshAccessToken();

    final retryResponse = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(body),
    );

    if (retryResponse.statusCode == 401) {
      throw Exception('Session expired');
    }

    return retryResponse;
  }

  Future<http.Response> _authPatch(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('$host/$endpoint');

    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 401) {
      return response;
    }

    await _refreshAccessToken();

    final retryResponse = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(body),
    );

    if (retryResponse.statusCode == 401) {
      throw Exception('Session expired');
    }

    return retryResponse;
  }

  Future<void> _refreshAccessToken() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (refreshToken == null) {
      throw Exception('Not authenticated');
    }

    final uri = Uri.parse('$host/$refreshEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode != 200) {
      await storage.delete(key: 'refresh_token');
      throw Exception('Session expired');
    }

    final decoded = jsonDecode(response.body);

    user.accessToken = decoded['access_token'];

    await storage.write(key: 'refresh_token', value: decoded['refresh_token']);
  }

  Future<void> destroy() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (refreshToken != null) {
      await http.post(
        Uri.parse('$host/$logoutEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );
    }

    await storage.delete(key: 'refresh_token');
  }

  Future<User> store({required String name, required String password}) async {
    final uri = Uri.parse('$host/$loginEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'password': password}),
    );

    if (response.statusCode == 401) {
      throw Exception(response.body);
    }

    if (response.statusCode != 201) {
      throw Exception('Login failed');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    await storage.write(key: 'refresh_token', value: decoded['refresh_token']);

    user = User.fromJson(decoded);
    return user;
  }

  // TODO: Consider extracting book related methods
  Future<bool> storeBook({required int bookId}) async {
    final endpoint = ApiRoutes.userBooks
        .replaceAll("{user}", user.id)
        .replaceAll("{book}", bookId.toString());

    final response = await _authPost(endpoint, {});

    if (response.statusCode == 409) {
      throw Exception(
        'Failed to add book for user, book already in collection...',
      );
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to add book for user');
    }

    return true;
  }

  Future<List<UserBook>> getBooks() async {
    final endpoint = userBooksEndpoint
        .replaceAll('{user}', user.id.toString())
        .replaceAll('/{book}', '');

    developer.log(endpoint.toString());

    final response = await _authGet(endpoint);

    if (response.statusCode == 404) {
      throw Exception('You have no books yet, check the explore page! :)');
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to get books for user, please try again later');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final list = (decoded['data']?['user_books'] as List?) ?? const [];

    return list
        .map((e) => UserBook.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteBook(int bookId) async {
    final endpoint = userBooksEndpoint
        .replaceAll('{user}', user.id.toString())
        .replaceAll('{book}', bookId.toString());

    final response = await _authDelete(endpoint);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete book for user, please try again later');
    }
  }

  Future<String> changeEmail({
    required String oldEmail,
    required String newEmail,
  }) async {
    final endpoint = registrationEmailEndpoint.replaceAll(
      '{user}',
      user.id.toString(),
    );

    final response = await _authPatch(endpoint, {
      'old_email': oldEmail,
      'new_email': newEmail,
    });

    if (response.statusCode == 400 ||
        response.statusCode == 409 ||
        response.statusCode == 422) {
      throw Exception(response.body);
    }

    if (response.statusCode != 200) {
      throw Exception(
        jsonEncode({
          'errors': {
            'message': ['Failed to update email'],
          },
        }),
      );
    }

    user.email = newEmail;
    return newEmail;
  }

  // Future<http.StreamedResponse> downloadEpub({required int bookId}) async {
  Future<void> downloadEpub({required int bookId}) async {
    developer.log("Download book...");
    //   final endpoint = '$host/epubsEndpoint'.replaceAll('{book}', bookId.toString());

    //   FileDownloader.downloadFile(
    //     url: endpoint,
    //     headers: {
    //       'Content-Type': 'application/epub+zip',
    //       'Authorization': 'Bearer ${user.accessToken}',
    //     },
    //     name: "$bookId.epub",
    //     subPath: "epubs/",
    //     onDownloadCompleted: (String path) {
    //       developer.log('FILE DOWNLOADED TO PATH: $path');
    //     },
    //   );
  }
}
