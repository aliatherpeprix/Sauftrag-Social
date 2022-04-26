// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_Kind_Model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarKindModel _$BarKindModelFromJson(Map<String, dynamic> json) => BarKindModel()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..created_at = json['created_at'] as String?
  ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$BarKindModelToJson(BarKindModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
