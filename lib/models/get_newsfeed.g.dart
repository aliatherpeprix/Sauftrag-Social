// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_newsfeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewsFeed _$GetNewsFeedFromJson(Map<String, dynamic> json) => GetNewsFeed()
  ..id = json['id'] as int?
  ..post_id = json['post_id'] == null
      ? null
      : NewsfeedPostId.fromJson(json['post_id'] as Map<String, dynamic>)
  ..media = json['media'] as String?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$GetNewsFeedToJson(GetNewsFeed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'media': instance.media,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
