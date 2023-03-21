import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recepie.g.dart';

@JsonSerializable()
class Recepie {
  final List<String> ingredients;
  final List<String> tools;
  final int servingAmount;
  final String difficulty;
  final String slection;
  final String? kitchen;

  Recepie(this.ingredients, this.tools, this.servingAmount, this.difficulty,
      this.slection, this.kitchen);

  factory Recepie.fromJson(Map<String, dynamic> json) =>
      _$RecepieFromJson(json);
  Map<String, dynamic> toJson() => _$RecepieToJson(this);
}
