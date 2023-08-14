import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';

final searchTextProvider = StateProvider<String>((_) => '');

final ingredientDataProvider = FutureProvider<List<Ingredient>>((ref) async {
  return ApiService.fetchIngredient();
});
final categoryDataProvider = FutureProvider<List<String>>((ref) async {
  return ApiService.fetchCategory();
});

final selectedCategoriesProvider = StateProvider<List<String>>(
  (ref) => [],
);

class SelectedIngredientNotifier
    extends StateNotifier<List<SelectedIngredient>> {
  SelectedIngredientNotifier() : super([]);

  void removeIngredient(SelectedIngredient ingredient) {
    if (ingredient.quantity > 1) {
      state = [
        for (final ingr in state)
          if (ingr != ingredient) ingr else ingredient.decreaseQuantity()
      ];
      return;
    }

    state = [
      for (final ingr in state)
        if (ingr != ingredient) ingr,
    ];
  }

  void addIngredient(SelectedIngredient ingredient) {
    if (state.contains(ingredient)) {
      state = [
        for (final ingr in state)
          if (ingr != ingredient) ingr else ingredient.increaseQuantity()
      ];
      return;
    }

    state = [...state, ingredient];
  }
}

final StateNotifierProvider<SelectedIngredientNotifier,
        List<SelectedIngredient>> selectedIngredientProvider =
    StateNotifierProvider((ref) => SelectedIngredientNotifier());
