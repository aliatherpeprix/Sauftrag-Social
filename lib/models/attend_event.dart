import 'package:json_annotation/json_annotation.dart';


part 'attend_event.g.dart';

@JsonSerializable()

class AttendEvent {
  AttendEvent();

  int? event_id;


  factory AttendEvent.fromJson(Map<String, dynamic> json) => _$AttendEventFromJson(json);
  Map<String, dynamic> toJson() => _$AttendEventToJson(this);

}