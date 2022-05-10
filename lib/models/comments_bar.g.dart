// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsfeedCommentsBar _$NewsfeedCommentsBarFromJson(Map<String, dynamic> json) =>
    NewsfeedCommentsBar()
      ..id = json['id'] as int?
      ..user_id = (json['user_id'] as List<dynamic>?)
          ?.map((e) => NewBarModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..text = json['text'] as String?
      ..created_at = json['created_at'] as String?
      ..updated_at = json['updated_at'] as String?
      ..post = json['post'] as int?;

Map<String, dynamic> _$NewsfeedCommentsBarToJson(
        NewsfeedCommentsBar instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'text': instance.text,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'post': instance.post,
    };
