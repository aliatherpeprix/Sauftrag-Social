import 'package:json_annotation/json_annotation.dart';

part 'day_weekend.g.dart';

@JsonSerializable()

class DayWeekendModel {
  DayWeekendModel();

  String? day__id;
  String? day__name;

  factory DayWeekendModel.fromJson(Map<String, dynamic> json) => _$DayWeekendModelFromJson(json);
  Map<String, dynamic> toJson() => _$DayWeekendModelToJson(this);

}