import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location.dart';
import '../models/weather.dart';
import '../utils/constants.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Search for locations by city name using Geocoding API
  Future<List<Location>> searchLocations(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      final url = Uri.parse(
        '${ApiConstants.geocodingBaseUrl}/search?name=$query&count=10&language=en&format=json',
      );

      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final searchResponse = LocationSearchResponse.fromJson(jsonData);
        return searchResponse.results ?? [];
      } else {
        throw Exception('Failed to search locations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching locations: $e');
    }
  }

  /// Get weather data for a specific location
  Future<Weather> getWeather(double latitude, double longitude) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.weatherBaseUrl}/forecast?'
        'latitude=$latitude&'
        'longitude=$longitude&'
        'current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&'
        'daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,weather_code&'
        'timezone=auto&'
        'forecast_days=7',
      );

      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else {
        throw Exception('Failed to get weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting weather data: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
