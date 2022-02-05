import 'package:json_annotation/json_annotation.dart';

part 'faqs_questions.g.dart';

@JsonSerializable()

class FaqsModel {
  FaqsModel();

  int? id;
  String? question;
  String? answer;
  String? created_at;
  String? updated_at;

  factory FaqsModel.fromJson(Map<String, dynamic> json) => _$FaqsModelFromJson(json);
  Map<String, dynamic> toJson() => _$FaqsModelToJson(this);

}