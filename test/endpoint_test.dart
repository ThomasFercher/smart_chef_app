import 'package:flutter_test/flutter_test.dart';

import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/models/category.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:smart_chef_app/services/models/recipe.dart';
import 'package:smart_chef_app/services/models/recipe_response.dart';

void main() {
  test(
    'fetchIngredient',
    () async {
      final result = await ApiService.fetchIngredient();
      expect(result, isA<List<Ingredient>>());
    },
  );

  test(
    'fetchCategory',
    () async {
      final result = await ApiService.fetchCategory();
      expect(result, isA<List<Category>>());
    },
  );
  test(
    'postRecipe',
    () async {
      final result = await ApiService.postRecipe(
          Recipe([], [], 1, "Hard", "Selected", null));

      expect(result, isA<RecipeResponse>());
    },
  );
}
