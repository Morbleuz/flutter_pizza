import 'dart:convert';

import 'package:pizzeria/class/pizza.dart';
import 'package:http/http.dart' as http;

class PizzeriaService {
  static final String uri = 'http://localhost/api/pizza/index.php';

  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];

    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for (final value in json) {
          list.add(Pizza.fromJson(value));
        }
      } else {
        throw Exception('Impossible de récupérer les pizzas');
      }
    } catch (e) {
      throw e;
    }
    return list;
  }
}
