import 'dart:convert';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:http/http.dart' as http;
import 'package:smart_chef_app/services/model/category.dart';
import 'package:smart_chef_app/services/model/ingredient.dart';

class ApiService {
  String endpoint = "https://info.smartchef.ai";
  String ingredient = "/ingredients";
  String category = "/categories";

  Future<List<Ingredient>> fetchIngredient() async {
    final uri = Uri.parse('$endpoint$ingredient');
    try {
      final response = await http.get(
        uri,
      );
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
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Category>> fetchCategory() async {
    final uri = Uri.parse('$endpoint$category');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final result = jsonDecode(response.body);

      if (result is! List<dynamic>) throw Exception('Failed to load category');

      return result.map((category) => Category(title: category)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load category');
    }
  }

  final apiProvider = Provider<ApiService>(create: (ref) => ApiService());
}
