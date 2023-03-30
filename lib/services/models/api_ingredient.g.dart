// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiIngredient _$ApiIngredientFromJson(Map<String, dynamic> json) =>
    ApiIngredient(
      json['name'] as String,
      json['amount'] as String,
    );

Map<String, dynamic> _$ApiIngredientToJson(ApiIngredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
    };
