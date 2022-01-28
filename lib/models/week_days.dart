import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/day_week.dart';

part 'week_days.g.dart';

@JsonSerializable()

class WeekDaysModel {
  WeekDaysModel();

  List<DayWeekModel>? day;
  String? opening_time;
  String? closing_time;
  String? break_opening_time;
  String? break_closing_time;
  bool? is_weekend;
  String? created_at;
  String? updated_at;
  String? user_id;

  factory WeekDaysModel.fromJson(Map<String, dynamic> json) => _$WeekDaysModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeekDaysModelToJson(this);

}