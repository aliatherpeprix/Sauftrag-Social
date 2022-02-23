// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqs_questions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqsModel _$FaqsModelFromJson(Map<String, dynamic> json) => FaqsModel()
  ..id = json['id'] as int?
  ..question = json['question'] as String?
  ..answer = json['answer'] as String?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$FaqsModelToJson(FaqsModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
