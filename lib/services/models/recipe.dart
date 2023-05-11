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

  Recipe(this.ingredients, this.tools, this.servingAmount, this.difficulty,
      this.slection, this.kitchen);

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
