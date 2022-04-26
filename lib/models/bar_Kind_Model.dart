import 'package:json_annotation/json_annotation.dart';

part 'bar_Kind_Model.g.dart';

@JsonSerializable()

class BarKindModel {
  BarKindModel();

  int? id;
  String? name;
  String? created_at;
  String? updated_at;



  factory BarKindModel.fromJson(Map<String, dynamic> json) => _$BarKindModelFromJson(json);
  Map<String, dynamic> toJson() => _$BarKindModelToJson(this);

}