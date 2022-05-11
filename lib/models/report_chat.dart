import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data.dart';

part 'report_chat.g.dart';

@JsonSerializable()

class ReportChat {

  ReportChat();

  String? detail;

  factory ReportChat.fromJson(Map<String, dynamic> json) => _$ReportChatFromJson(json);
  Map<String, dynamic> toJson() => _$ReportChatToJson(this);
}
