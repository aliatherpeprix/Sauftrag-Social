import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

part 'comments_bar.g.dart';

@JsonSerializable()

class NewsfeedCommentsBar {
  NewsfeedCommentsBar();

  int? id;
  List<NewBarModel>? user_id;
  String? text;
  String? created_at;
  String? updated_at;
  int? post;

  factory NewsfeedCommentsBar.fromJson(Map<String, dynamic> json) => _$NewsfeedCommentsBarFromJson(json);
  Map<String, dynamic> toJson() => _$NewsfeedCommentsBarToJson(this);

}