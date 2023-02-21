// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  final int? id;
  final String? name;
  final String? category;
  final String? unit;
  final int? calories;
  final int? joules;
  final double? fat;
  final double? protein;
  final double? carbohydrates;

  const Ingredient(
      {required this.id,
      required this.name,
      required this.category,
      required this.unit,
      required this.calories,
      required this.joules,
      required this.fat,
      required this.protein,
      required this.carbohydrates});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
