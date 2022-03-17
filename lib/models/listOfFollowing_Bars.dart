import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data.dart';
import 'package:sauftrag/models/week_days.dart';
import 'package:sauftrag/models/weekend_days.dart';

import 'bar_event_model.dart';
import 'create_bar_post.dart';
import 'newsfeed_post_id.dart';

part 'listOfFollowing_Bars.g.dart';

@JsonSerializable()

class ListOfBarsModel {
  ListOfBarsModel();

  int? id;
  String? token;
  String? username;
  String? bar_name;
  String? email;
  String? address;
  dynamic role;
  List<int>? bar_kind;
  //WeekDaysModel? week_days;
  // String? opening_time;
  // String? closing_time;
  // String? break_opening_time;
  // String? break_closing_time;
  // String? created_at;
  // String? updated_at;
  // String? user_id;
  //WeekendDaysModel? weekend_days;
  // String? weekend_opening_time;
  // String? weekend_closing_time;
  // String? weekend_break_opening_time;
  // String? weekend_break_closing_time;
  String? profile_picture;
  String? catalogue_image1;
  String? catalogue_image2;
  String? catalogue_image3;
  String? catalogue_image4;
  String? catalogue_image5;
  bool? terms_conditions;
  bool? data_protection;
  String? password;
  String? password2;
  double? total_ratings;
  int? total_followers;
  int? total_posts;
  int? total_events;
  List<RatingData>? ratings;
  List<NewsfeedPostId>? posts;
  List<BarEventModel>? events;
  bool? is_follow;
  bool? is_rate;



  factory ListOfBarsModel.fromJson(Map<String, dynamic> json) => _$ListOfBarsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListOfBarsModelToJson(this);

}