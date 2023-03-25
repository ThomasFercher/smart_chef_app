import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final List<String> ingredients;
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
