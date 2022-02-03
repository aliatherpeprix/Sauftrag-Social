// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMedia _$PostMediaFromJson(Map<String, dynamic> json) => PostMedia()
  ..id = json['id'] as int?
  ..media = json['media'] as String?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?
  ..post_id = json['post_id'] as int?;

Map<String, dynamic> _$PostMediaToJson(PostMedia instance) => <String, dynamic>{
      'id': instance.id,
      'media': instance.media,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'post_id': instance.post_id,
    };
