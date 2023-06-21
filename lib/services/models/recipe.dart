import 'package:json_annotation/json_annotation.dart';
import 'package:smart_chef_app/services/models/api_ingredient.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final List<ApiIngredient> ingredients;
  final List<String> tools;
  final int servingAmount;
  final String difficulty;
  final String slection;
  final String? kitchen;

  const Recipe({
    required this.ingredients,
    required this.tools,
    required this.servingAmount,
    required this.difficulty,
    required this.slection,
    this.kitchen,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  String toString() {
    return 'Recipe{ingredients: $ingredients, tools: $tools, servingAmount: $servingAmount, difficulty: $difficulty, slection: $slection, kitchen: $kitchen}';
  }
}
