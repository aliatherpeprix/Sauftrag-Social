// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupChat _$CreateGroupChatFromJson(Map<String, dynamic> json) =>
    CreateGroupChat()
      ..id = json['id'] as int?
      ..name = json['name'] as String?
      ..privacy = json['privacy'] as String?
      ..originator = json['originator']
      ..image = json['image'] as String?
      ..users = (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CreateGroupChatToJson(CreateGroupChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'privacy': instance.privacy,
      'originator': instance.originator,
      'image': instance.image,
      'users': instance.users,
    };
