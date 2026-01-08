import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';

class HttpHelper {
  static const String authority = 'www.googleapis.com';
  static const path = '/books/v1/volumes';

  Future<List<Book>> getBooks(String query) async {
    Map<String, dynamic> params = {'q': query, 'maxResults':'40'};
    Uri uri = Uri.https(authority, path, params);
    final Response result = await http.get(uri);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final booksMap = jsonResponse['items'];
      List<Book> books = booksMap.map<Book>((b) => Book.fromJson(b)).toList();
      return books;
    } else {
      return [];
    }
  }

}