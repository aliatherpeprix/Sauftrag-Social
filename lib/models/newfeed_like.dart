import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data.dart';

part 'newfeed_like.g.dart';

@JsonSerializable()

class LikeNewsFeed {

  LikeNewsFeed();

  String? details;

  factory LikeNewsFeed.fromJson(Map<String, dynamic> json) => _$LikeNewsFeedFromJson(json);
  Map<String, dynamic> toJson() => _$LikeNewsFeedToJson(this);
}
