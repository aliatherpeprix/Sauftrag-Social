// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_drink_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkStatus _$DrinkStatusFromJson(Map<String, dynamic> json) => DrinkStatus()
  ..id = json['id'] as int?
  ..quantity = json['quantity'] as int?
  ..start_time = json['start_time'] as String?
  ..end_time = json['end_time'] as String?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?
  ..user_id = json['user_id'] as int?;

Map<String, dynamic> _$DrinkStatusToJson(DrinkStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user_id': instance.user_id,
    };
