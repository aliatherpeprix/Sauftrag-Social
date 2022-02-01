import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/day_weekend.dart';

part 'weekend_days.g.dart';

@JsonSerializable()

class WeekendDaysModel {
  WeekendDaysModel();

  List<DayWeekendModel>? day;
  String? opening_time;
  String? closing_time;
  String? break_opening_time;
  String? break_closing_time;
  bool? is_weekend;
  String? created_at;
  String? updated_at;
  int? user_id;

  factory WeekendDaysModel.fromJson(Map<String, dynamic> json) => _$WeekendDaysModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeekendDaysModelToJson(this);

}