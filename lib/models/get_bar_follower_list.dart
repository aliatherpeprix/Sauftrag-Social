import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/request_match_model.dart';
import 'package:sauftrag/models/user_models.dart';
part 'get_bar_follower_list.g.dart';

@JsonSerializable()
class GetBarFollowersList {

  GetBarFollowersList();

  int? id;
  /*NewBarModel? follow_to;*/
  List<UserModel>? follow_by;


  factory GetBarFollowersList.fromJson(Map<String, dynamic> json) => _$GetBarFollowersListFromJson(json);
  Map<String, dynamic> toJson() => _$GetBarFollowersListToJson(this);
}
