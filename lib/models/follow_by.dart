import 'package:json_annotation/json_annotation.dart';
part 'follow_by.g.dart';

@JsonSerializable()
class FollowBy {
  FollowBy();
  int? id;
  String? username;
  String? profile_picture;

  factory FollowBy.fromJson(Map<String, dynamic> json) => _$FollowByFromJson(json);
  Map<String, dynamic> toJson() => _$FollowByToJson(this);
}
