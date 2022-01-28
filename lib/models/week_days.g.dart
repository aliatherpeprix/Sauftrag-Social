// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekDaysModel _$WeekDaysModelFromJson(Map<String, dynamic> json) =>
    WeekDaysModel()
      ..day = (json['day'] as List<dynamic>?)
          ?.map((e) => DayWeekModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..opening_time = json['opening_time'] as String?
      ..closing_time = json['closing_time'] as String?
      ..break_opening_time = json['break_opening_time'] as String?
      ..break_closing_time = json['break_closing_time'] as String?
      ..is_weekend = json['is_weekend'] as bool?
      ..created_at = json['created_at'] as String?
      ..updated_at = json['updated_at'] as String?
      ..user_id = json['user_id'] as String?;

Map<String, dynamic> _$WeekDaysModelToJson(WeekDaysModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'opening_time': instance.opening_time,
      'closing_time': instance.closing_time,
      'break_opening_time': instance.break_opening_time,
      'break_closing_time': instance.break_closing_time,
      'is_weekend': instance.is_weekend,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user_id': instance.user_id,
    };
