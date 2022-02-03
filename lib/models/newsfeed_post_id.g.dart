// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsfeed_post_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsfeedPostId _$NewsfeedPostIdFromJson(Map<String, dynamic> json) =>
    NewsfeedPostId()
      ..id = json['id'] as int?
      ..user_id = json['user_id'] == null
          ? null
          : NewBarModel.fromJson(json['user_id'] as Map<String, dynamic>)
      ..post_type = json['post_type'] as int?
      ..post_location = json['post_location'] as String?
      ..post_content = json['post_content'] as String?
      ..created_at = json['created_at'] as String?
      ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$NewsfeedPostIdToJson(NewsfeedPostId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'post_type': instance.post_type,
      'post_location': instance.post_location,
      'post_content': instance.post_content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
