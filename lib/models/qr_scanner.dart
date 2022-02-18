import 'package:json_annotation/json_annotation.dart';
import 'package:sauftrag/models/rating_data_user.dart';

part 'qr_scanner.g.dart';

@JsonSerializable()

class BarQRCode {
  BarQRCode();

  dynamic user_id;

  factory BarQRCode.fromJson(Map<String, dynamic> json) => _$BarQRCodeFromJson(json);
  Map<String, dynamic> toJson() => _$BarQRCodeToJson(this);
}

