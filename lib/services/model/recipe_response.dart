import 'package:json_annotation/json_annotation.dart';

part 'recipe_response.g.dart';

@JsonSerializable()
class RecipeResponse {
  final String name;
  final int length;
  final int servingAmount;
  final List<dynamic> ingredients;
  final List<dynamic> tools;
  final List<String> steps;
  final List<String> tips;

  const RecipeResponse(
      {required this.name,
      required this.length,
      required this.servingAmount,
      required this.ingredients,
      required this.tools,
      required this.steps,
      required this.tips});

  factory RecipeResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}
