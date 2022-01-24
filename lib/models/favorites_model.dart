import 'package:json_annotation/json_annotation.dart';

part 'favorites_model.g.dart';

@JsonSerializable()

class FavoritesModel {

  FavoritesModel();

  int? id;
  String? name;
  String? created_at;
  String? updated_at;



  factory FavoritesModel.fromJson(Map<String, dynamic> json) => _$FavoritesModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesModelToJson(this);

}