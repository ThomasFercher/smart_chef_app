import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/content/services/api_service.dart';
import '../model/category.dart';
import '../model/ingredient.dart';

final ingredientDataProvider = FutureProvider<List<Ingredient>>((ref) async {
  final apiProvider = Provider<ApiService>((ref) => ApiService());
  return ref.read(apiProvider).fetchIngredient();
});
final categoryDataProvider = FutureProvider<List<Category>>((ref) async {
  final apiProvider = Provider<ApiService>((ref) => ApiService());
  return ref.read(apiProvider).fetchCategory();
});
