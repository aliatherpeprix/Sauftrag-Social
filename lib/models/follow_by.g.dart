// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_by.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowBy _$FollowByFromJson(Map<String, dynamic> json) => FollowBy()
  ..id = json['id'] as int?
  ..username = json['username'] as String?
  ..address = json['address'] as String?
  ..profile_picture = json['profile_picture'] as String?;

Map<String, dynamic> _$FollowByToJson(FollowBy instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'address': instance.address,
      'profile_picture': instance.profile_picture,
    };
