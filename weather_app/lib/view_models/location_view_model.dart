import 'package:flutter/foundation.dart';
import '../models/location.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

enum LocationSearchState {
  initial,
  searching,
  loaded,
  error,
  empty,
}

class LocationViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final LocalStorageService _storageService;

  LocationViewModel(this._apiService, this._storageService) {
    _loadFavorites();
    _loadSearchHistory();
  }

  LocationSearchState _state = LocationSearchState.initial;
  List<Location> _searchResults = [];
  List<Location> _favorites = [];
  List<Location> _searchHistory = [];
  String? _errorMessage;

  LocationSearchState get state => _state;
  List<Location> get searchResults => _searchResults;
  List<Location> get favorites => _favorites;
  List<Location> get searchHistory => _searchHistory;
  String? get errorMessage => _errorMessage;

  Future<void> searchLocations(String query) async {
    if (query.trim().isEmpty) {
      _state = LocationSearchState.initial;
      _searchResults = [];
      notifyListeners();
      return;
    }

    _state = LocationSearchState.searching;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _apiService.searchLocations(query);

      if (_searchResults.isEmpty) {
        _state = LocationSearchState.empty;
      } else {
        _state = LocationSearchState.loaded;
      }
    } catch (e) {
      _state = LocationSearchState.error;
      _errorMessage = e.toString();
      _searchResults = [];
    }

    notifyListeners();
  }

  void clearSearch() {
    _state = LocationSearchState.initial;
    _searchResults = [];
    _errorMessage = null;
    notifyListeners();
  }

  // Favorites Management
  Future<void> toggleFavorite(Location location) async {
    final isFav = await _storageService.isFavorite(location);
    if (isFav) {
      await _storageService.removeFavorite(location);
    } else {
      await _storageService.addFavorite(location);
    }
    await _loadFavorites();
  }

  Future<bool> isFavorite(Location location) async {
    return await _storageService.isFavorite(location);
  }

  Future<void> _loadFavorites() async {
    _favorites = await _storageService.getFavorites();
    notifyListeners();
  }

  // Search History Management
  Future<void> _loadSearchHistory() async {
    _searchHistory = await _storageService.getSearchHistory();
    notifyListeners();
  }

  Future<void> clearSearchHistory() async {
    await _storageService.clearSearchHistory();
    await _loadSearchHistory();
  }
}
