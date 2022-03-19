import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable()

class FiltersModel {

  FiltersModel();

  String? user_id__bar_name__icontains;
  int? user_id__bar_kind__id;
  bool? is_today;
  bool? is_tomorrow;
  bool? is_week;
  String? event_date;
  double? distance_range_start;
  double? distance_range_end;

  factory FiltersModel.fromJson(Map<String, dynamic> json) => _$FiltersModelFromJson(json);
  Map<String, dynamic> toJson() => _$FiltersModelToJson(this);

}