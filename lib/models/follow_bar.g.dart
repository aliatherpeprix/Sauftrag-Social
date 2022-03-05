// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowBAR _$FollowBARFromJson(Map<String, dynamic> json) => FollowBAR()
  ..details = json['details'] as String?
  ..status = json['status'] as String?
  ..user = (json['user'] as List<dynamic>?)
      ?.map((e) => NewBarModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FollowBARToJson(FollowBAR instance) => <String, dynamic>{
      'details': instance.details,
      'status': instance.status,
      'user': instance.user,
    };
