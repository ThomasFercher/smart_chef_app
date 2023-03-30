import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/models/recipe.dart';
import 'package:smart_chef_app/services/models/recipe_response.dart';

final recipeProvider =
    StateNotifierProvider<RecipeNotifier, AsyncValue<RecipeResponse>>((ref) {
  return RecipeNotifier();
});

class RecipeNotifier extends StateNotifier<AsyncValue<RecipeResponse>> {
  RecipeNotifier() : super(const AsyncValue.loading());

  Future<void> getRecipe(Recipe recipe) async {
    try {
      final result = await ApiService.postRecipe(recipe);
      state = AsyncValue.data(result);
    } catch (e, s) {
      state = AsyncValue.error(e.toString(), s);
    }
  }
}
