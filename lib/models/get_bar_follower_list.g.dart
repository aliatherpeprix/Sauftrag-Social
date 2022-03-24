// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bar_follower_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBarFollowersList _$GetBarFollowersListFromJson(Map<String, dynamic> json) =>
    GetBarFollowersList()
      ..id = json['id'] as int?
      ..follow_by = (json['follow_by'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetBarFollowersListToJson(
        GetBarFollowersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'follow_by': instance.follow_by,
    };
