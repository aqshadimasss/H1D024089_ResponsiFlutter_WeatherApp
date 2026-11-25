import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String? country;
  final String? admin1; // State/Province

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.country,
    this.admin1,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  String get displayName {
    final parts = <String>[name];
    if (admin1 != null && admin1!.isNotEmpty) parts.add(admin1!);
    if (country != null && country!.isNotEmpty) parts.add(country!);
    return parts.join(', ');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@JsonSerializable()
class LocationSearchResponse {
  final List<Location>? results;

  LocationSearchResponse({this.results});

  factory LocationSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchResponseToJson(this);
}
