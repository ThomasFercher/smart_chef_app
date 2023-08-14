// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  final int id;
  final String name;
  final String category;
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

class SelectedIngredient {
  final Ingredient ingredient;
  final int quantity;

  const SelectedIngredient({required this.ingredient, required this.quantity});

  const SelectedIngredient.init({required this.ingredient}) : quantity = 1;

  // copy with
  SelectedIngredient copyWith({Ingredient? ingredient, int? quantity}) {
    return SelectedIngredient(
      ingredient: ingredient ?? this.ingredient,
      quantity: quantity ?? this.quantity,
    );
  }

  // Increase quantity
  SelectedIngredient increaseQuantity() {
    return SelectedIngredient(
      ingredient: ingredient,
      quantity: quantity + 1,
    );
  }

  // Decrease quantity
  SelectedIngredient decreaseQuantity() {
    return SelectedIngredient(
      ingredient: ingredient,
      quantity: quantity - 1,
    );
  }
}
