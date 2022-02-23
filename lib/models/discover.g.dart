// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discover _$DiscoverFromJson(Map<String, dynamic> json) => Discover()
  ..id = json['id'] as int?
  ..username = json['username'] as String?
  ..address = json['address'] as String?
  ..profile_picture = json['profile_picture'] as String?;

Map<String, dynamic> _$DiscoverToJson(Discover instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'address': instance.address,
      'profile_picture': instance.profile_picture,
    };
