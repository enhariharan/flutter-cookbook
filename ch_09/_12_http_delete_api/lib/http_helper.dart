import 'dart:convert';
import 'dart:io';

import '/pizza.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'm9601.wiremockapi.cloud';

  Future<List<Pizza>> getPizzaList() async {
    final String path = '/pizzalist';
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

  Future<String> postPizza(Pizza pizza) async {
    const postPath = '/pizza';
    String body = json.encode(pizza.toJson());
    final Uri uri = Uri.https(authority, postPath);
    final http.Response response = await http.post(uri, body: body);
    return response.body;
  }

  Future<String> putPizza(Pizza pizza) async {
    const putPath = '/pizza';
    String body = json.encode(pizza.toJson());
    final Uri uri = Uri.https(authority, putPath);
    final http.Response response = await http.put(uri, body: body);
    return response.body;
  }

  Future<String> deletePizza(int id) async {
    const deletePath = '/pizza';
    final Uri uri = Uri.https(authority, deletePath);
    final http.Response response = await http.delete(uri);
    return response.body;
  }
}