import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/request_match_model.dart';
import 'package:sauftrag/models/user_models.dart';
part 'get_bar_followers.g.dart';

@JsonSerializable()
class GetBarFollower {

  GetBarFollower();

  int? id;
  /*NewBarModel? follow_to;*/
  List<UserModel?>? follow_by;


  factory GetBarFollower.fromJson(Map<String, dynamic> json) => _$GetBarFollowerFromJson(json);
  Map<String, dynamic> toJson() => _$GetBarFollowerToJson(this);
}
