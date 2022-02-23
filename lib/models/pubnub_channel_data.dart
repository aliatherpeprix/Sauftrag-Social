import 'package:json_annotation/json_annotation.dart';

part 'pubnub_channel_data.g.dart';

@JsonSerializable()
class   pnChannelData {
  pnChannelData();
  String? channels;

  factory pnChannelData.fromJson(Map<String, dynamic> json) =>
      _$pnChannelDataFromJson(json);
  Map<String, dynamic> toJson() => _$pnChannelDataToJson(this);
}
