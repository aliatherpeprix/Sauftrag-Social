// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comments_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewsfeedCommentsBar _$GetNewsfeedCommentsBarFromJson(
        Map<String, dynamic> json) =>
    GetNewsfeedCommentsBar()
      ..id = json['id'] as int?
      ..user_id = json['user_id'] == null
          ? null
          : NewBarModel.fromJson(json['user_id'] as Map<String, dynamic>)
      ..text = json['text'] as String?
      ..created_at = json['created_at'] as String?
      ..updated_at = json['updated_at'] as String?
      ..post = json['post'] as int?;

Map<String, dynamic> _$GetNewsfeedCommentsBarToJson(
        GetNewsfeedCommentsBar instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'text': instance.text,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'post': instance.post,
    };
