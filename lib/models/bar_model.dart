import 'package:json_annotation/json_annotation.dart';

part 'bar_model.g.dart';

@JsonSerializable()

class BarModel {
  BarModel();

  int? id;
  String? token;
  String? username;
  String? bar_name;
  String? email;
  String? address;
  dynamic role;
  List? bar_kind;
  List? week_days;
  String? opening_time;
  String? closing_time;
  String? break_opening_time;
  String? break_closing_time;
  String? created_at;
  String? updated_at;
  String? user_id;
  List? weekend_days;
  String? weekend_opening_time;
  String? weekend_closing_time;
  String? weekend_break_opening_time;
  String? weekend_break_closing_time;
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


  factory BarModel.fromJson(Map<String, dynamic> json) => _$BarModelFromJson(json);
  Map<String, dynamic> toJson() => _$BarModelToJson(this);

}