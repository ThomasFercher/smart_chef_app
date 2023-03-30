import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/models/category.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';

final ingredientDataProvider = FutureProvider<List<Ingredient>>((ref) async {
  return ApiService.fetchIngredient();
});
final categoryDataProvider = FutureProvider<List<Category>>((ref) async {
  return ApiService.fetchCategory();
});
final categoryProvider = StateProvider<String>(
  (ref) => "Meats",
);

class SelectedIngredientNotifier extends StateNotifier<List<Ingredient>> {
  SelectedIngredientNotifier() : super([]);

  void removeIngredient(Ingredient ingredientRemove) => state = [
        for (final ingredient in state)
          if (ingredient != ingredientRemove) ingredient,
      ];

  void addIngredient(Ingredient ingredient) => state = [...state, ingredient];
}

final StateNotifierProvider<SelectedIngredientNotifier, List<Ingredient>>
    selectedIngredient =
    StateNotifierProvider((ref) => SelectedIngredientNotifier());
