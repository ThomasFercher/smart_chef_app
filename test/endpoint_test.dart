import 'package:flutter_test/flutter_test.dart';

import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/model/category.dart';
import 'package:smart_chef_app/services/model/ingredient.dart';
import 'package:smart_chef_app/services/model/recipe.dart';
import 'package:smart_chef_app/services/model/recipe_response.dart';

void main() {
  test(
    'fetchIngredient',
    () async {
      final apiService = ApiService();
      final result = await apiService.fetchIngredient();
      expect(result, isA<List<Ingredient>>());
    },
  );

  test(
    'fetchCategory',
    () async {
      final apiService = ApiService();
      final result = await apiService.fetchCategory();
      expect(result, isA<List<Category>>());
    },
  );
  test(
    'postRecipe',
    () async {
      final apiService = ApiService();
      final result = await apiService.postRecipe(new Recipe(
          ["Pasta, raw", "Parmesan", "Tomato"],
          [],
          1,
          "Hard",
          "Selected",
          null));

      expect(result, isA<RecipeResponse>());
    },
  );
}
