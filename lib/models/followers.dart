import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/follow_by.dart';
part 'followers.g.dart';

@JsonSerializable()
class FollowersList {
  FollowersList();
  int? id;
  FollowBy? follow_by;

  factory FollowersList.fromJson(Map<String, dynamic> json) =>
      _$FollowersListFromJson(json);
  Map<String, dynamic> toJson() => _$FollowersListToJson(this);
}
