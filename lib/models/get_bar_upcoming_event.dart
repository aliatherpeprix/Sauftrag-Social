import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/bar/views/Drawer/list_of_allBars.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/post_media.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

import 'bar_event_model.dart';
import 'event_attendees.dart';
import 'listOfFollowing_Bars.dart';
import 'newsfeed_post_id.dart';

part 'get_bar_upcoming_event.g.dart';

@JsonSerializable()

class GetEvent {
  GetEvent();

  int? id;
  String? name;
  String? about;
  dynamic lat;
  dynamic long;
  String? location;
  String? event_date;
  String? start_time;
  String? end_time;
  ListOfBarsModel? user_id;
  List<Media>? media;
  double? distance;
  bool? is_attend;
  List<EventAttendees>? going_users;


  factory GetEvent.fromJson(Map<String, dynamic> json) => _$GetEventFromJson(json);
  Map<String, dynamic> toJson() => _$GetEventToJson(this);

}