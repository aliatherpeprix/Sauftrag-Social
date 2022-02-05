// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_data_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingDataUser _$RatingDataUserFromJson(Map<String, dynamic> json) =>
    RatingDataUser()
      ..id = json['id'] as int?
      ..username = json['username'] as String?
      ..profile_picture = json['profile_picture'] as String?;

Map<String, dynamic> _$RatingDataUserToJson(RatingDataUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profile_picture': instance.profile_picture,
    };
