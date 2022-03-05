import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data.dart';

part 'ratings.g.dart';

@JsonSerializable()

class Ratings {

  Ratings();
  double? total_rating;
  List<RatingData>? data;

  factory Ratings.fromJson(Map<String, dynamic> json) =>
      _$RatingsFromJson(json);
  Map<String, dynamic> toJson() => _$RatingsToJson(this);
}
