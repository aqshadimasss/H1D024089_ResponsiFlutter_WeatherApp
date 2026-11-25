// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      time: json['time'] as String,
      temperature2m: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity2m: (json['relative_humidity_2m'] as num).toInt(),
      apparentTemperature: (json['apparent_temperature'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      weatherCode: (json['weather_code'] as num).toInt(),
      windSpeed10m: (json['wind_speed_10m'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2m,
      'relative_humidity_2m': instance.relativeHumidity2m,
      'apparent_temperature': instance.apparentTemperature,
      'precipitation': instance.precipitation,
      'weather_code': instance.weatherCode,
      'wind_speed_10m': instance.windSpeed10m,
    };

DailyWeather _$DailyWeatherFromJson(Map<String, dynamic> json) => DailyWeather(
  time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
  temperature2mMax: (json['temperature_2m_max'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  temperature2mMin: (json['temperature_2m_min'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  precipitationProbabilityMax:
      (json['precipitation_probability_max'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  weatherCode: (json['weather_code'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$DailyWeatherToJson(DailyWeather instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m_max': instance.temperature2mMax,
      'temperature_2m_min': instance.temperature2mMin,
      'precipitation_probability_max': instance.precipitationProbabilityMax,
      'weather_code': instance.weatherCode,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  timezone: json['timezone'] as String,
  current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
  daily: DailyWeather.fromJson(json['daily'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'timezone': instance.timezone,
  'current': instance.current,
  'daily': instance.daily,
};
