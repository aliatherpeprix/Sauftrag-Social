import 'package:json_annotation/json_annotation.dart';

part 'create_bar_post.g.dart';

@JsonSerializable()

class CreateBarPost {
  CreateBarPost();

  int? id;
  dynamic post_type;
  String? post_location;
  String? post_content;
  List? media;

  factory CreateBarPost.fromJson(Map<String, dynamic> json) => _$CreateBarPostFromJson(json);
  Map<String, dynamic> toJson() => _$CreateBarPostToJson(this);

}