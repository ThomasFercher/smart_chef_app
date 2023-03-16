import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/model/category.dart';
import 'package:smart_chef_app/services/model/ingredient.dart';

final ingredientDataProvider = FutureProvider<List<Ingredient>>((ref) async {
  final apiProvider = Provider<ApiService>((ref) => ApiService());
  return ref.read(apiProvider).fetchIngredient();
});
final categoryDataProvider = FutureProvider<List<Category>>((ref) async {
  final apiProvider = Provider<ApiService>((ref) => ApiService());
  return ref.read(apiProvider).fetchCategory();
});
final categoryProvider = StateProvider<String>(
  (ref) => "Meats",
);
