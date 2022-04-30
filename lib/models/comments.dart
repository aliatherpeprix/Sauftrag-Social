import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

part 'comments.g.dart';

@JsonSerializable()

class NewsfeedComments {
  NewsfeedComments();

  int? id;
  List<NewBarModel>? user_id;
  String? text;
  String? created_at;
  String? updated_at;
  int? post;

  factory NewsfeedComments.fromJson(Map<String, dynamic> json) => _$NewsfeedCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsfeedCommentsToJson(this);

}