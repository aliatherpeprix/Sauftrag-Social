// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupChat _$CreateGroupChatFromJson(Map<String, dynamic> json) =>
    CreateGroupChat()
      ..id = json['id'] as int?
      ..name = json['name'] as String?
      ..privacy = json['privacy'] as int?
      ..originator = json['originator']
      ..users =
          (json['users'] as List<dynamic>?)?.map((e) => e as int).toList();

Map<String, dynamic> _$CreateGroupChatToJson(CreateGroupChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'privacy': instance.privacy,
      'originator': instance.originator,
      'users': instance.users,
    };
