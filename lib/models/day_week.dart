import 'package:json_annotation/json_annotation.dart';

part 'day_week.g.dart';

@JsonSerializable()

class DayWeekModel {
  DayWeekModel();

  String? day__id;
  String? day__name;

  factory DayWeekModel.fromJson(Map<String, dynamic> json) => _$DayWeekModelFromJson(json);
  Map<String, dynamic> toJson() => _$DayWeekModelToJson(this);

}