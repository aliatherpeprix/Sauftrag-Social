import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

import 'bar_event_model.dart';
import 'newsfeed_post_id.dart';

part 'event_attendees.g.dart';

@JsonSerializable()

class EventAttendees {
  EventAttendees();

  int? id;
  UserModel? user_id;


  factory EventAttendees.fromJson(Map<String, dynamic> json) => _$EventAttendeesFromJson(json);
  Map<String, dynamic> toJson() => _$EventAttendeesToJson(this);

}