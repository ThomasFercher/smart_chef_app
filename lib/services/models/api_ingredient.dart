import 'package:json_annotation/json_annotation.dart';

part 'api_ingredient.g.dart';

@JsonSerializable()
class ApiIngredient {
  String name;
  String amount;

  ApiIngredient(this.name, this.amount);

  factory ApiIngredient.fromJson(Map<String, dynamic> json) =>
      _$ApiIngredientFromJson(json);
  Map<String, dynamic> toJson() => _$ApiIngredientToJson(this);
}
