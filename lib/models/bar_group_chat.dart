import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user.dart';
import 'package:sauftrag/models/user_models.dart';

part 'bar_group_chat.g.dart';

@JsonSerializable()

class BarGroupChat {
  BarGroupChat();

  int? id;
  String? name;
  String? privacy;
  User? originator;
  String? image;
  List<User>? users;

  factory BarGroupChat.fromJson(Map<String, dynamic> json) => _$BarGroupChatFromJson(json);
  Map<String, dynamic> toJson() => _$BarGroupChatToJson(this);

}