// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listOfFollowing_Bars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOfBarsModel _$ListOfBarsModelFromJson(Map<String, dynamic> json) =>
    ListOfBarsModel()
      ..id = json['id'] as int?
      ..token = json['token'] as String?
      ..username = json['username'] as String?
      ..bar_name = json['bar_name'] as String?
      ..email = json['email'] as String?
      ..address = json['address'] as String?
      ..role = json['role']
      ..bar_kind =
          (json['bar_kind'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..week_days = json['week_days'] == null
          ? null
          : WeekDaysModel.fromJson(json['week_days'] as Map<String, dynamic>)
      ..weekend_days = json['weekend_days'] == null
          ? null
          : WeekendDaysModel.fromJson(
              json['weekend_days'] as Map<String, dynamic>)
      ..profile_picture = json['profile_picture'] as String?
      ..catalogue_image1 = json['catalogue_image1'] as String?
      ..catalogue_image2 = json['catalogue_image2'] as String?
      ..catalogue_image3 = json['catalogue_image3'] as String?
      ..catalogue_image4 = json['catalogue_image4'] as String?
      ..catalogue_image5 = json['catalogue_image5'] as String?
      ..terms_conditions = json['terms_conditions'] as bool?
      ..data_protection = json['data_protection'] as bool?
      ..password = json['password'] as String?
      ..password2 = json['password2'] as String?
      ..total_ratings = (json['total_ratings'] as num?)?.toDouble()
      ..total_followers = json['total_followers'] as int?
      ..total_posts = json['total_posts'] as int?
      ..total_events = json['total_events'] as int?
      ..ratings = (json['ratings'] as List<dynamic>?)
          ?.map((e) => RatingData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..posts = (json['posts'] as List<dynamic>?)
          ?.map((e) => NewsfeedPostId.fromJson(e as Map<String, dynamic>))
          .toList()
      ..events = (json['events'] as List<dynamic>?)
          ?.map((e) => BarEventModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ListOfBarsModelToJson(ListOfBarsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'username': instance.username,
      'bar_name': instance.bar_name,
      'email': instance.email,
      'address': instance.address,
      'role': instance.role,
      'bar_kind': instance.bar_kind,
      'week_days': instance.week_days,
      'weekend_days': instance.weekend_days,
      'profile_picture': instance.profile_picture,
      'catalogue_image1': instance.catalogue_image1,
      'catalogue_image2': instance.catalogue_image2,
      'catalogue_image3': instance.catalogue_image3,
      'catalogue_image4': instance.catalogue_image4,
      'catalogue_image5': instance.catalogue_image5,
      'terms_conditions': instance.terms_conditions,
      'data_protection': instance.data_protection,
      'password': instance.password,
      'password2': instance.password2,
      'total_ratings': instance.total_ratings,
      'total_followers': instance.total_followers,
      'total_posts': instance.total_posts,
      'total_events': instance.total_events,
      'ratings': instance.ratings,
      'posts': instance.posts,
      'events': instance.events,
    };
