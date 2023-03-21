// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recepie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recepie _$RecepieFromJson(Map<String, dynamic> json) => Recepie(
      (json['ingredients'] as List<dynamic>).map((e) => e as String).toList(),
      (json['tools'] as List<dynamic>).map((e) => e as String).toList(),
      json['servingAmount'] as int,
      json['difficulty'] as String,
      json['slection'] as String,
      json['kitchen'] as String?,
    );

Map<String, dynamic> _$RecepieToJson(Recepie instance) => <String, dynamic>{
      'ingredients': instance.ingredients,
      'tools': instance.tools,
      'servingAmount': instance.servingAmount,
      'difficulty': instance.difficulty,
      'slection': instance.slection,
      'kitchen': instance.kitchen,
    };
