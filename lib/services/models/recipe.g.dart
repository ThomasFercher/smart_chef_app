// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => ApiIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      tools: (json['tools'] as List<dynamic>).map((e) => e as String).toList(),
      servingAmount: json['servingAmount'] as int,
      difficulty: json['difficulty'] as String,
      slection: json['slection'] as String,
      kitchen: json['kitchen'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'ingredients': instance.ingredients,
      'tools': instance.tools,
      'servingAmount': instance.servingAmount,
      'difficulty': instance.difficulty,
      'slection': instance.slection,
      'kitchen': instance.kitchen,
    };
