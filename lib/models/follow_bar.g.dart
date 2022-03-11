// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowBAR _$FollowBARFromJson(Map<String, dynamic> json) => FollowBAR()
  ..details = json['details'] as String?
  ..status = json['status'] as int?
  ..user = json['user'] == null
      ? null
      : NewBarModel.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$FollowBARToJson(FollowBAR instance) => <String, dynamic>{
      'details': instance.details,
      'status': instance.status,
      'user': instance.user,
    };
