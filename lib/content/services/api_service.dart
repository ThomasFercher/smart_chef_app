import 'dart:convert';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:http/http.dart' as http;
import '../model/ingredient.dart';

class ApiService {
  String endpoint = "http://194.233.172.64/ingredients";

  Future<List<Ingredient>> fetchIngredient() async {
    final response =
        await http.get(Uri.parse("http://194.233.172.64/ingredients"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List result = jsonDecode(response.body);
      return result.map((e) => Ingredient.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ingredient');
    }
  }

  final apiProvider = Provider<ApiService>(create: (ref) => ApiService());
}
