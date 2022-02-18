import 'package:json_annotation/json_annotation.dart';

part 'discover.g.dart';

@JsonSerializable()
class Discover {
  Discover();
  int? id;
  String? username;
  String? address;
  String? profile_picture;

  factory Discover.fromJson(Map<String, dynamic> json) => _$DiscoverFromJson(json);
  Map<String, dynamic> toJson() => _$DiscoverToJson(this);

}
