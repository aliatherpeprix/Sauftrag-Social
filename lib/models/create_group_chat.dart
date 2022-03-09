import 'package:json_annotation/json_annotation.dart';

part 'create_group_chat.g.dart';

@JsonSerializable()

class CreateGroupChat {
  CreateGroupChat();

  int? id;
  String? name;
  int? privacy;
  int? originator;
  List? users;

  factory CreateGroupChat.fromJson(Map<String, dynamic> json) => _$CreateGroupChatFromJson(json);
  Map<String, dynamic> toJson() => _$CreateGroupChatToJson(this);

}