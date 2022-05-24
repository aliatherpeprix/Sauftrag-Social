// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_group_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarGroupChat _$BarGroupChatFromJson(Map<String, dynamic> json) => BarGroupChat()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..privacy = json['privacy'] as String?
  ..originator = json['originator'] == null
      ? null
      : User.fromJson(json['originator'] as Map<String, dynamic>)
  ..image = json['image'] as String?
  ..users = (json['users'] as List<dynamic>?)
      ?.map((e) => User.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$BarGroupChatToJson(BarGroupChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'privacy': instance.privacy,
      'originator': instance.originator,
      'image': instance.image,
      'users': instance.users,
    };
