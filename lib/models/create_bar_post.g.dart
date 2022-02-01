// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bar_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBarPost _$CreateBarPostFromJson(Map<String, dynamic> json) =>
    CreateBarPost()
      ..post_type = json['post_type']
      ..post_location = json['post_location'] as String?
      ..post_content = json['post_content'] as String?
      ..media = json['media'] as List<dynamic>?;

Map<String, dynamic> _$CreateBarPostToJson(CreateBarPost instance) =>
    <String, dynamic>{
      'post_type': instance.post_type,
      'post_location': instance.post_location,
      'post_content': instance.post_content,
      'media': instance.media,
    };
