// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bar_followers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBarFollower _$GetBarFollowerFromJson(Map<String, dynamic> json) =>
    GetBarFollower()
      ..id = json['id'] as int?
      ..follow_by = json['follow_by'] == null
          ? null
          : UserModel.fromJson(json['follow_by'] as Map<String, dynamic>);

Map<String, dynamic> _$GetBarFollowerToJson(GetBarFollower instance) =>
    <String, dynamic>{
      'id': instance.id,
      'follow_by': instance.follow_by,
    };
