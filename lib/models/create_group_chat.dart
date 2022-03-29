import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/user_models.dart';

part 'create_group_chat.g.dart';

@JsonSerializable()

class CreateGroupChat {
  CreateGroupChat();

  int? id;
  String? name;
  dynamic privacy;
  dynamic originator;
  List<dynamic>? users;

  factory CreateGroupChat.fromJson(Map<String, dynamic> json) => _$CreateGroupChatFromJson(json);
  Map<String, dynamic> toJson() => _$CreateGroupChatToJson(this);

}