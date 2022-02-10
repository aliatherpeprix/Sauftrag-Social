// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBook _$AddressBookFromJson(Map<String, dynamic> json) => AddressBook()
  ..username = json['username'] as String?
  ..phone_no = json['phone_no'] as String?
  ..exist = json['exist'] as bool?;

Map<String, dynamic> _$AddressBookToJson(AddressBook instance) =>
    <String, dynamic>{
      'username': instance.username,
      'phone_no': instance.phone_no,
      'exist': instance.exist,
    };
