// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventAttendees _$EventAttendeesFromJson(Map<String, dynamic> json) =>
    EventAttendees()
      ..id = json['id'] as int?
      ..user_id = json['user_id'] == null
          ? null
          : UserModel.fromJson(json['user_id'] as Map<String, dynamic>);

Map<String, dynamic> _$EventAttendeesToJson(EventAttendees instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
    };
