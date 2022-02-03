// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsfeed_post_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsfeedPostId _$NewsfeedPostIdFromJson(Map<String, dynamic> json) =>
    NewsfeedPostId()
      ..post_type = json['post_type'] as int?
      ..post_location = json['post_location'] as String?
      ..post_content = json['post_content'] as String?
      ..user_id = json['user_id'] == null
          ? null
          : NewBarModel.fromJson(json['user_id'] as Map<String, dynamic>)
      ..media = (json['media'] as List<dynamic>?)
          ?.map((e) => PostMedia.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$NewsfeedPostIdToJson(NewsfeedPostId instance) =>
    <String, dynamic>{
      'post_type': instance.post_type,
      'post_location': instance.post_location,
      'post_content': instance.post_content,
      'user_id': instance.user_id,
      'media': instance.media,
    };
