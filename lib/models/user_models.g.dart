// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = json['id'] as int?
  ..username = json['username'] as String?
  ..email = json['email'] as String?
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
  ..favorite_night_club = json['favorite_night_club'] as List<dynamic>?
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
  ..token = json['token'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
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
      'favorite_night_club': instance.favorite_night_club,
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
    };
