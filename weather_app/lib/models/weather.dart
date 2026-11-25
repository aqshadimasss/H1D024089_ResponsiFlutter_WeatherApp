import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class CurrentWeather {
  final String time;
  @JsonKey(name: 'temperature_2m')
  final double temperature2m;
  @JsonKey(name: 'relative_humidity_2m')
  final int relativeHumidity2m;
  @JsonKey(name: 'apparent_temperature')
  final double apparentTemperature;
  final double precipitation;
  @JsonKey(name: 'weather_code')
  final int weatherCode;
  @JsonKey(name: 'wind_speed_10m')
  final double windSpeed10m;

  CurrentWeather({
    required this.time,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed10m,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}

@JsonSerializable()
class DailyWeather {
  final List<String> time;
  @JsonKey(name: 'temperature_2m_max')
  final List<double> temperature2mMax;
  @JsonKey(name: 'temperature_2m_min')
  final List<double> temperature2mMin;
  @JsonKey(name: 'precipitation_probability_max')
  final List<int> precipitationProbabilityMax;
  @JsonKey(name: 'weather_code')
  final List<int> weatherCode;

  DailyWeather({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.precipitationProbabilityMax,
    required this.weatherCode,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherToJson(this);
}

@JsonSerializable()
class Weather {
  final double latitude;
  final double longitude;
  final String timezone;
  final CurrentWeather current;
  final DailyWeather daily;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.current,
    required this.daily,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
