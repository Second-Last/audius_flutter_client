// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilepicture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePicture _$ProfilePictureFromJson(Map<String, dynamic> json) {
  return ProfilePicture(
    json['150x150'] as String?,
    json['480x480'] as String?,
    json['1000x1000'] as String?,
  );
}

Map<String, dynamic> _$ProfilePictureToJson(ProfilePicture instance) =>
    <String, dynamic>{
      '150x150': instance.p150x150,
      '480x480': instance.p480x480,
      '1000x1000': instance.p1000x1000,
    };
