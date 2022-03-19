// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiltersModel _$FiltersModelFromJson(Map<String, dynamic> json) => FiltersModel()
  ..user_id__bar_name__icontains =
      json['user_id__bar_name__icontains'] as String?
  ..user_id__bar_kind__id = json['user_id__bar_kind__id'] as int?
  ..is_today = json['is_today'] as bool?
  ..is_tomorrow = json['is_tomorrow'] as bool?
  ..is_week = json['is_week'] as bool?
  ..event_date = json['event_date'] as String?
  ..distance_range_start = (json['distance_range_start'] as num?)?.toDouble()
  ..distance_range_end = (json['distance_range_end'] as num?)?.toDouble();

Map<String, dynamic> _$FiltersModelToJson(FiltersModel instance) =>
    <String, dynamic>{
      'user_id__bar_name__icontains': instance.user_id__bar_name__icontains,
      'user_id__bar_kind__id': instance.user_id__bar_kind__id,
      'is_today': instance.is_today,
      'is_tomorrow': instance.is_tomorrow,
      'is_week': instance.is_week,
      'event_date': instance.event_date,
      'distance_range_start': instance.distance_range_start,
      'distance_range_end': instance.distance_range_end,
    };
