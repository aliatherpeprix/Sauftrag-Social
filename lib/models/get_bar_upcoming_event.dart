import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

import 'bar_event_model.dart';
import 'event_attendees.dart';
import 'newsfeed_post_id.dart';

part 'get_bar_upcoming_event.g.dart';

@JsonSerializable()

class GetUpcomingEvent {
  GetUpcomingEvent();

  int? id;
  String? name;
  String? about;
  String? lat;
  String? long;
  String? location;
  String? event_date;
  String? start_time;
  String? end_time;
  NewBarModel? user_id;
  List<Media>? media;
  double? distance;
  bool? is_attend;
  List<EventAttendees>? going_users;


  factory GetUpcomingEvent.fromJson(Map<String, dynamic> json) => _$GetUpcomingEventFromJson(json);
  Map<String, dynamic> toJson() => _$GetUpcomingEventToJson(this);

}