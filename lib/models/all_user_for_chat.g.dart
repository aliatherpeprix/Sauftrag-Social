// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_user_for_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserForChat _$UserForChatFromJson(Map<String, dynamic> json) => UserForChat()
  ..id = json['id'] as int?
  ..username = json['username'] as String?
  ..email = json['email'] as String?
  ..profile_picture = json['profile_picture'] as String?
  ..role = json['role'] as int?;

Map<String, dynamic> _$UserForChatToJson(UserForChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'profile_picture': instance.profile_picture,
      'role': instance.role,
    };
