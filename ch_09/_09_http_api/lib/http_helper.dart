import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:_09_http_api/pizza.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'm9601.wiremockapi.cloud';
  final String path = 'pizzalist';

  Future<List<Pizza>> getPizzaList() async {
    final Uri uri = Uri.https(authority, path);
    final http.Response response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List<Pizza> pizzas = jsonResponse.map<Pizza>((json) => Pizza.fromJson(json)).toList();
      return pizzas;
    } else {
      return [];
    }
  }
}