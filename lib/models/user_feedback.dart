import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data.dart';

part 'user_feedback.g.dart';

@JsonSerializable()

class UserFeedBack {

  UserFeedBack();

  String? detail;

  factory UserFeedBack.fromJson(Map<String, dynamic> json) => _$UserFeedBackFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedBackToJson(this);
}
