import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data_user.dart';

part 'rating_data.g.dart';

@JsonSerializable()
class RatingData {
  RatingData();
  int? id;
  RatingDataUser? user;
  double? rate;
  String? comments;
  String? created_at;

  factory RatingData.fromJson(Map<String, dynamic> json) =>
      _$RatingDataFromJson(json);
  Map<String, dynamic> toJson() => _$RatingDataToJson(this);
}
