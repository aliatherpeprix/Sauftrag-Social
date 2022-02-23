// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ratings _$RatingsFromJson(Map<String, dynamic> json) => Ratings()
  ..total_rating = (json['total_rating'] as num?)?.toDouble()
  ..data = (json['data'] as List<dynamic>?)
      ?.map((e) => RatingData.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$RatingsToJson(Ratings instance) => <String, dynamic>{
      'total_rating': instance.total_rating,
      'data': instance.data,
    };
