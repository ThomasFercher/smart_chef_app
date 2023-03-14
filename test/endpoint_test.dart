import 'package:flutter_test/flutter_test.dart';
import 'package:smart_chef_app/content/model/category.dart';
import 'package:smart_chef_app/content/model/ingredient.dart';
import 'package:smart_chef_app/content/services/api_service.dart';

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
}
