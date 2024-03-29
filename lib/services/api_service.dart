import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:smart_chef_app/services/models/recipe.dart';
import 'package:smart_chef_app/services/models/recipe_response.dart';

const String endpoint = "https://info.smartchef.ai";
const String ingredient = "/ingredients";
const String category = "/categories";
const String getRecipe = "/recipe";

abstract class ApiService {
  static Future<List<Ingredient>> fetchIngredient() async {
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
      rethrow;
    }
  }

  static Future<List<String>> fetchCategory() async {
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

      return result.map((category) => category.toString()).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load category');
    }
  }

  static Future<RecipeResponse> postRecipe(Recipe recipe) async {
    final uri = Uri.parse('$endpoint$getRecipe');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(recipe.toJson()),
    );
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      return RecipeResponse.fromJson(json);
    } else {
      throw Exception("Unable to post recipe");
    }
  }
}
