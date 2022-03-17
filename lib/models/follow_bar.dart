import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
part 'follow_bar.g.dart';

@JsonSerializable()
class FollowBAR {

  FollowBAR();

  String? details;
  int? status;
  NewBarModel? user;

  factory FollowBAR.fromJson(Map<String, dynamic> json) => _$FollowBARFromJson(json);
  Map<String, dynamic> toJson() => _$FollowBARToJson(this);
}
