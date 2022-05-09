import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

part 'get_comments_bar.g.dart';

@JsonSerializable()

class GetNewsfeedCommentsBar {
  GetNewsfeedCommentsBar();

  int? id;
  NewBarModel? user_id;
  String? text;
  String? created_at;
  String? updated_at;
  int? post;

  factory GetNewsfeedCommentsBar.fromJson(Map<String, dynamic> json) => _$GetNewsfeedCommentsBarFromJson(json);
  Map<String, dynamic> toJson() => _$GetNewsfeedCommentsBarToJson(this);

}