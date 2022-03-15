// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bar_upcoming_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUpcomingEvent _$GetUpcomingEventFromJson(Map<String, dynamic> json) =>
    GetUpcomingEvent()
      ..id = json['id'] as int?
      ..name = json['name'] as String?
      ..about = json['about'] as String?
      ..lat = json['lat'] as String?
      ..long = json['long'] as String?
      ..location = json['location'] as String?
      ..event_date = json['event_date'] as String?
      ..start_time = json['start_time'] as String?
      ..end_time = json['end_time'] as String?
      ..user_id = json['user_id'] == null
          ? null
          : NewBarModel.fromJson(json['user_id'] as Map<String, dynamic>)
      ..media = (json['media'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetUpcomingEventToJson(GetUpcomingEvent instance) =>
    <String, dynamic>{
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
    };
