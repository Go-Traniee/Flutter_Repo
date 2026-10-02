import 'package:json_annotation/json_annotation.dart';
//يمثل شكل رد السيرفر (مشترك بين ريجستر ولوجين)
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);}

@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final String message;
  final UserModel user;
  final String token;

  AuthResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}