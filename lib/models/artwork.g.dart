// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artwork _$ArtworkFromJson(Map<String, dynamic> json) {
  return Artwork(
    x150: json['150x150'] as String?,
    x480: json['480x480'] as String?,
    x1000: json['1000x1000'] as String?,
  );
}

Map<String, dynamic> _$ArtworkToJson(Artwork instance) => <String, dynamic>{
      '150x150': instance.x150,
      '480x480': instance.x480,
      '1000x1000': instance.x1000,
    };
