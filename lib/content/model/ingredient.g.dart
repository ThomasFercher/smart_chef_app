// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as int?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      unit: json['unit'] as String?,
      calories: json['calories'] as int?,
      joules: json['joules'] as int?,
      fat: (json['fat'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'unit': instance.unit,
      'calories': instance.calories,
      'joules': instance.joules,
      'fat': instance.fat,
      'protein': instance.protein,
      'carbohydrates': instance.carbohydrates,
    };
