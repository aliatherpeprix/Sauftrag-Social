// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as int?
  ..username = json['username'] as String?
  ..email = json['email'] as String?
  ..about = json['about'] as String?
  ..country_code = json['country_code'] as String?
  ..phone_no = json['phone_no'] as String?
  ..gender = json['gender']
  ..address = json['address'] as String?
  ..dob = json['dob'] as String?
  ..relation_ship = json['relation_ship']
  ..latitude = json['latitude'] as String?
  ..longitude = json['longitude'] as String?
  ..role = json['role']
  ..favorite_alcohol_drinks = json['favorite_alcohol_drinks'] as List<dynamic>?
  ..favorite_musics = json['favorite_musics'] as List<dynamic>?
  ..favorite_party_vacation = json['favorite_party_vacation'] as List<dynamic>?
  ..profile_picture = json['profile_picture'] as String?
  ..catalogue_image1 = json['catalogue_image1'] as String?
  ..catalogue_image2 = json['catalogue_image2'] as String?
  ..catalogue_image3 = json['catalogue_image3'] as String?
  ..catalogue_image4 = json['catalogue_image4'] as String?
  ..catalogue_image5 = json['catalogue_image5'] as String?
  ..terms_conditions = json['terms_conditions'] as bool?
  ..data_protection = json['data_protection'] as bool?
  ..password = json['password'] as String?
  ..password2 = json['password2'] as String?
  ..token = json['token'] as String?
  ..friends = (json['friends'] as List<dynamic>?)
      ?.map((e) => UserMatchedModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..distance = (json['distance'] as num?)?.toDouble()
  ..drinking_motivation = json['drinking_motivation'] as List<dynamic>?
  ..bar_kind =
      (json['bar_kind'] as List<dynamic>?)?.map((e) => e as int).toList()
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
  ..weekend_break_closing_time = json['weekend_break_closing_time'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'about': instance.about,
      'country_code': instance.country_code,
      'phone_no': instance.phone_no,
      'gender': instance.gender,
      'address': instance.address,
      'dob': instance.dob,
      'relation_ship': instance.relation_ship,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'role': instance.role,
      'favorite_alcohol_drinks': instance.favorite_alcohol_drinks,
      'favorite_musics': instance.favorite_musics,
      'favorite_party_vacation': instance.favorite_party_vacation,
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
      'token': instance.token,
      'friends': instance.friends,
      'distance': instance.distance,
      'drinking_motivation': instance.drinking_motivation,
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
    };
