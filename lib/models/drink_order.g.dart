// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkOrder _$DrinkOrderFromJson(Map<String, dynamic> json) => DrinkOrder()
  ..user_id = json['user_id'] as int?
  ..order_details = json['order_details'] as List<dynamic>?;

Map<String, dynamic> _$DrinkOrderToJson(DrinkOrder instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'order_details': instance.order_details,
    };
