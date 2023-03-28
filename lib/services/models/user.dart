import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final bool isVerified;
  final bool isAdmin;

  const User({
    required this.id,
    required this.email,
    required this.isVerified,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
