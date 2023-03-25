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
      ingredients: json['ingredients'] as List<dynamic>,
      tools: json['tools'] as List<dynamic>,
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
