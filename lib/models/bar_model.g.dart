// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarModel _$BarModelFromJson(Map<String, dynamic> json) => BarModel()
  ..id = json['id'] as int?
  ..token = json['token'] as String?
  ..username = json['username'] as String?
  ..bar_name = json['bar_name'] as String?
  ..email = json['email'] as String?
  ..address = json['address'] as String?
  ..role = json['role']
  ..bar_kind = json['bar_kind'] as List<dynamic>?
  ..week_days = json['week_days'] as List<dynamic>?
  ..opening_time = json['opening_time'] as String?
  ..closing_time = json['closing_time'] as String?
  ..break_opening_time = json['break_opening_time'] as String?
  ..break_closing_time = json['break_closing_time'] as String?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?
  ..user_id = json['user_id'] as String?
  ..weekend_days = json['weekend_days'] as List<dynamic>?
  ..weekend_opening_time = json['weekend_opening_time'] as String?
  ..weekend_closing_time = json['weekend_closing_time'] as String?
  ..weekend_break_opening_time = json['weekend_break_opening_time'] as String?
  ..weekend_break_closing_time = json['weekend_break_closing_time'] as String?
  ..profile_picture = json['profile_picture'] as String?
  ..catalogue_image1 = json['catalogue_image1'] as String?
  ..catalogue_image2 = json['catalogue_image2'] as String?
  ..catalogue_image3 = json['catalogue_image3'] as String?
  ..catalogue_image4 = json['catalogue_image4'] as String?
  ..catalogue_image5 = json['catalogue_image5'] as String?
  ..terms_conditions = json['terms_conditions'] as bool?
  ..data_protection = json['data_protection'] as bool?
  ..password = json['password'] as String?
  ..password2 = json['password2'] as String?;

Map<String, dynamic> _$BarModelToJson(BarModel instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'username': instance.username,
      'bar_name': instance.bar_name,
      'email': instance.email,
      'address': instance.address,
      'role': instance.role,
      'bar_kind': instance.bar_kind,
      'week_days': instance.week_days,
      'opening_time': instance.opening_time,
      'closing_time': instance.closing_time,
      'break_opening_time': instance.break_opening_time,
      'break_closing_time': instance.break_closing_time,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user_id': instance.user_id,
      'weekend_days': instance.weekend_days,
      'weekend_opening_time': instance.weekend_opening_time,
      'weekend_closing_time': instance.weekend_closing_time,
      'weekend_break_opening_time': instance.weekend_break_opening_time,
      'weekend_break_closing_time': instance.weekend_break_closing_time,
      'profile_picture': instance.profile_picture,
      'catalogue_image1': instance.catalogue_image1,
      'catalogue_image2': instance.catalogue_image2,
      'catalogue_image3': instance.catalogue_image3,
      'catalogue_image4': instance.catalogue_image4,
      'catalogue_image5': instance.catalogue_image5,
      'terms_conditions': instance.terms_conditions,
      'data_protection': instance.data_protection,
      'password': instance.password,
      'password2': instance.password2,
    };
