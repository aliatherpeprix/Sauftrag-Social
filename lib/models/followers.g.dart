// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowersList _$FollowersListFromJson(Map<String, dynamic> json) =>
    FollowersList()
      ..id = json['id'] as int?
      ..follow_by = json['follow_by'] == null
          ? null
          : FollowBy.fromJson(json['follow_by'] as Map<String, dynamic>);

Map<String, dynamic> _$FollowersListToJson(FollowersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'follow_by': instance.follow_by,
    };
