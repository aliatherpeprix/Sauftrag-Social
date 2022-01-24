// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesModel _$FavoritesModelFromJson(Map<String, dynamic> json) =>
    FavoritesModel()
      ..id = json['id'] as int?
      ..name = json['name'] as String?
      ..created_at = json['created_at'] as String?
      ..updated_at = json['updated_at'] as String?;

Map<String, dynamic> _$FavoritesModelToJson(FavoritesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
