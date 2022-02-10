import 'package:json_annotation/json_annotation.dart';

part 'address_book.g.dart';

@JsonSerializable()

class AddressBook {
  AddressBook();

  String? username;
  String? phone_no;
  bool? exist;

  factory AddressBook.fromJson(Map<String, dynamic> json) => _$AddressBookFromJson(json);
  Map<String, dynamic> toJson() => _$AddressBookToJson(this);

}