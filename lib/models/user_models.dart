import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/user_matched.dart';

part 'user_models.g.dart';

@JsonSerializable()

class UserModel {
  UserModel();

  int? id;
  String? username;
  String? email;
  String? about;
  String? country_code;
  String? phone_no;
  dynamic gender;
  String? address;
  String? dob;
  dynamic relation_ship;
  String? latitude;
  String? longitude;
  dynamic role;
  List?  favorite_alcohol_drinks;
  List? favorite_musics;
  List? favorite_party_vacation;
  String? profile_picture;
  String? catalogue_image1;
  String? catalogue_image2;
  String? catalogue_image3;
  String? catalogue_image4;
  String? catalogue_image5;
  bool? terms_conditions;
  bool? data_protection;
  String? password;
  String? password2;
  String? token;
  List<UserMatchedModel>? friends;
  double? distance;
  List? drinking_motivation;


  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}