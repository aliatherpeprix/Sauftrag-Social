import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

import 'newsfeed_post_id.dart';

part 'get_newsfeed.g.dart';

@JsonSerializable()

class GetNewsFeed {
  GetNewsFeed();

  int? id;
  NewsfeedPostId?  post_id;
  String? media;
  String? created_at;
  String? updated_at;




  factory GetNewsFeed.fromJson(Map<String, dynamic> json) => _$GetNewsFeedFromJson(json);
  Map<String, dynamic> toJson() => _$GetNewsFeedToJson(this);

}