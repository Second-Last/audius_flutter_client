// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilepicture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePicture _$ProfilePictureFromJson(Map<String, dynamic> json) {
  return ProfilePicture(
    json['p150x150'] as String?,
    json['p480x480'] as String?,
    json['p1000x1000'] as String?,
  );
}

Map<String, dynamic> _$ProfilePictureToJson(ProfilePicture instance) =>
    <String, dynamic>{
      'p150x150': instance.p150x150,
      'p480x480': instance.p480x480,
      'p1000x1000': instance.p1000x1000,
    };
