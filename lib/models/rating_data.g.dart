// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingData _$RatingDataFromJson(Map<String, dynamic> json) => RatingData()
  ..id = json['id'] as int?
  ..user = json['user'] == null
      ? null
      : RatingDataUser.fromJson(json['user'] as Map<String, dynamic>)
  ..rate = (json['rate'] as num?)?.toDouble()
  ..comments = json['comments'] as String?
  ..created_at = json['created_at'] as String?;

Map<String, dynamic> _$RatingDataToJson(RatingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'rate': instance.rate,
      'comments': instance.comments,
      'created_at': instance.created_at,
    };
