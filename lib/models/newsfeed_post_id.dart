import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

part 'newsfeed_post_id.g.dart';

@JsonSerializable()

class NewsfeedPostId {
  NewsfeedPostId();

  int? id;
  int? post_type;
  String? post_location;
  String? post_content;
  NewBarModel? user_id;
  List<PostMedia>? media;
  int? likes;

  factory NewsfeedPostId.fromJson(Map<String, dynamic> json) => _$NewsfeedPostIdFromJson(json);
  Map<String, dynamic> toJson() => _$NewsfeedPostIdToJson(this);

}