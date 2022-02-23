import 'package:json_annotation/json_annotation.dart';

part 'all_user_for_chat.g.dart';

@JsonSerializable()
class UserForChat {
  UserForChat();
  int? id;
  String? username;
  String? email;
  String? profile_picture;
  int? role;

  factory UserForChat.fromJson(Map<String, dynamic> json) =>
      _$UserForChatFromJson(json);
  Map<String, dynamic> toJson() => _$UserForChatToJson(this);
}
