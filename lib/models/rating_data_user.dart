import 'package:json_annotation/json_annotation.dart';

part 'rating_data_user.g.dart';

@JsonSerializable()
class RatingDataUser {

  RatingDataUser();
  int? id;
  String? username;
  String? profile_picture;

  factory RatingDataUser.fromJson(Map<String, dynamic> json) =>
      _$RatingDataUserFromJson(json);
  Map<String, dynamic> toJson() => _$RatingDataUserToJson(this);
}
