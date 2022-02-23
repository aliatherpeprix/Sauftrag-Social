import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/pubnub_channel_data.dart';

part 'pubnub_channel.g.dart';

@JsonSerializable()
class PubnubChannel {
  PubnubChannel();
  String? channels;

  factory PubnubChannel.fromJson(Map<String, dynamic> json) =>
      _$PubnubChannelFromJson(json);
  Map<String, dynamic> toJson() => _$PubnubChannelToJson(this);
}
