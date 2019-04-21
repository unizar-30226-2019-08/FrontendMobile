// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['displayName'] as String,
      json['pictureURL'] as String,
      json['uid'] as String,
      json['city'] as String,
      (json['rating'] as num)?.toDouble(),
      json['ratingsAmount'] as int,
      json['online'] as bool,
      json['banned'] as bool);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'pictureURL': instance.pictureURL,
      'uid': instance.uid,
      'city': instance.city,
      'rating': instance.rating,
      'ratingsAmount': instance.ratingsAmount,
      'online': instance.online,
      'banned': instance.banned
    };
