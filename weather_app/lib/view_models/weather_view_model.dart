import 'package:flutter/foundation.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

enum WeatherState {
  initial,
  loading,
  loaded,
  error,
  empty,
}

class WeatherViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final LocalStorageService _storageService;

  WeatherViewModel(this._apiService, this._storageService) {
    _initialize();
  }

  WeatherState _state = WeatherState.initial;
  Weather? _weather;
  Location? _currentLocation;
  String? _errorMessage;

  WeatherState get state => _state;
  Weather? get weather => _weather;
  Location? get currentLocation => _currentLocation;
  String? get errorMessage => _errorMessage;

  Future<void> _initialize() async {
    // Load last selected location
    final lastLocation = await _storageService.getLastSelectedLocation();
    if (lastLocation != null) {
      await loadWeather(lastLocation);
    }
  }

  Future<void> loadWeather(Location location) async {
    _state = WeatherState.loading;
    _currentLocation = location;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _apiService.getWeather(
        location.latitude,
        location.longitude,
      );

      // Save as last selected location
      await _storageService.saveLastSelectedLocation(location);
      await _storageService.addToSearchHistory(location);

      _state = WeatherState.loaded;
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> refreshWeather() async {
    if (_currentLocation != null) {
      await loadWeather(_currentLocation!);
    }
  }

  void clearError() {
    _errorMessage = null;
    if (_state == WeatherState.error) {
      _state = WeatherState.initial;
      notifyListeners();
    }
  }
}
