// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  country: json['country'] as String?,
  admin1: json['admin1'] as String?,
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'country': instance.country,
  'admin1': instance.admin1,
};

LocationSearchResponse _$LocationSearchResponseFromJson(
  Map<String, dynamic> json,
) => LocationSearchResponse(
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LocationSearchResponseToJson(
  LocationSearchResponse instance,
) => <String, dynamic>{'results': instance.results};
