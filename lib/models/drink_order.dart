import 'package:json_annotation/json_annotation.dart';

part 'drink_order.g.dart';

@JsonSerializable()

class DrinkOrder {

  DrinkOrder();

  int? user_id;
  List? order_details;

  factory DrinkOrder.fromJson(Map<String, dynamic> json) => _$DrinkOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DrinkOrderToJson(this);

}