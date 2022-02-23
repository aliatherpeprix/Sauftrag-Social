import 'package:json_annotation/json_annotation.dart';
part 'get_drink_status.g.dart';

@JsonSerializable()
class DrinkStatus {
  DrinkStatus();
  int? id;
  int? quantity;
  String? start_time;
  String? end_time;
  String? created_at;
  String? updated_at;
  int? user_id;

  factory DrinkStatus.fromJson(Map<String, dynamic> json) =>
      _$DrinkStatusFromJson(json);
  Map<String, dynamic> toJson() => _$DrinkStatusToJson(this);
}
