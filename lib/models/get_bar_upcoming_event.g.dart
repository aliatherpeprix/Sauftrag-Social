// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bar_upcoming_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEvent _$GetEventFromJson(Map<String, dynamic> json) => GetEvent()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..about = json['about'] as String?
  ..lat = json['lat']
  ..long = json['long']
  ..location = json['location'] as String?
  ..event_date = json['event_date'] as String?
  ..start_time = json['start_time'] as String?
  ..end_time = json['end_time'] as String?
  ..user_id = json['user_id'] == null
      ? null
      : ListOfBarsModel.fromJson(json['user_id'] as Map<String, dynamic>)
  ..media = (json['media'] as List<dynamic>?)
      ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
      .toList()
  ..distance = (json['distance'] as num?)?.toDouble()
  ..is_attend = json['is_attend'] as bool?
  ..going_users = (json['going_users'] as List<dynamic>?)
      ?.map((e) => EventAttendees.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$GetEventToJson(GetEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'about': instance.about,
      'lat': instance.lat,
      'long': instance.long,
      'location': instance.location,
      'event_date': instance.event_date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'user_id': instance.user_id,
      'media': instance.media,
      'distance': instance.distance,
      'is_attend': instance.is_attend,
      'going_users': instance.going_users,
    };
