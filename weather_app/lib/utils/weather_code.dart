import 'package:flutter/material.dart';

class WeatherCodeUtil {
  static String getDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Mainly clear';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 56:
      case 57:
        return 'Freezing drizzle';
      case 61:
        return 'Light rain';
      case 63:
        return 'Moderate rain';
      case 65:
        return 'Heavy rain';
      case 66:
      case 67:
        return 'Freezing rain';
      case 71:
        return 'Light snow';
      case 73:
        return 'Moderate snow';
      case 75:
        return 'Heavy snow';
      case 77:
        return 'Snow grains';
      case 80:
      case 81:
      case 82:
        return 'Rain showers';
      case 85:
      case 86:
        return 'Snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with hail';
      default:
        return 'Unknown';
    }
  }

  static IconData getIcon(int code, {bool isDay = true}) {
    switch (code) {
      case 0:
        return isDay ? Icons.wb_sunny : Icons.nights_stay;
      case 1:
        return isDay ? Icons.wb_sunny : Icons.nights_stay;
      case 2:
        return Icons.wb_cloudy;
      case 3:
        return Icons.cloud;
      case 45:
      case 48:
        return Icons.foggy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return Icons.grain;
      case 61:
      case 63:
      case 65:
        return Icons.beach_access; // rain icon
      case 66:
      case 67:
        return Icons.ac_unit;
      case 71:
      case 73:
      case 75:
      case 77:
        return Icons.ac_unit;
      case 80:
      case 81:
      case 82:
        return Icons.water;
      case 85:
      case 86:
        return Icons.ac_unit; // snow
      case 95:
        return Icons.thunderstorm;
      case 96:
      case 99:
        return Icons.thunderstorm;
      default:
        return Icons.help_outline;
    }
  }

  static Color getColor(int code) {
    switch (code) {
      case 0:
      case 1:
        return Colors.amber;
      case 2:
      case 3:
        return Colors.grey;
      case 45:
      case 48:
        return Colors.blueGrey;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
        return Colors.blue;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return Colors.lightBlue;
      case 95:
      case 96:
      case 99:
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }
}
