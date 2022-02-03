import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

import 'newsfeed_post_id.dart';

part 'post_media.g.dart';

@JsonSerializable()

class PostMedia {
  PostMedia();

  int? id;
  String? media;
  String? created_at;
  String? updated_at;
  int? post_id;

  factory PostMedia.fromJson(Map<String, dynamic> json) => _$PostMediaFromJson(json);
  Map<String, dynamic> toJson() => _$PostMediaToJson(this);

}