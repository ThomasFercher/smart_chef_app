// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeResponse _$RecipeResponseFromJson(Map<String, dynamic> json) =>
    RecipeResponse(
      name: json['name'] as String,
      length: json['length'] as int,
      servingAmount: json['servingAmount'] as int,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => ApiIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      tools: (json['tools'] as List<dynamic>).map((e) => e as String).toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      tips: (json['tips'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecipeResponseToJson(RecipeResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'length': instance.length,
      'servingAmount': instance.servingAmount,
      'ingredients': instance.ingredients,
      'tools': instance.tools,
      'steps': instance.steps,
      'tips': instance.tips,
    };
