import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/location.dart';
import '../utils/constants.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  // Favorite Locations
  Future<void> addFavorite(Location location) async {
    final favorites = await getFavorites();
    if (!favorites.any((loc) => loc.id == location.id)) {
      favorites.add(location);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(Location location) async {
    final favorites = await getFavorites();
    favorites.removeWhere((loc) => loc.id == location.id);
    await _saveFavorites(favorites);
  }

  Future<List<Location>> getFavorites() async {
    final favoritesJson = _prefs.getStringList(ApiConstants.favoritesKey) ?? [];
    return favoritesJson
        .map((json) => Location.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<bool> isFavorite(Location location) async {
    final favorites = await getFavorites();
    return favorites.any((loc) => loc.id == location.id);
  }

  Future<void> _saveFavorites(List<Location> favorites) async {
    final favoritesJson =
        favorites.map((loc) => jsonEncode(loc.toJson())).toList();
    await _prefs.setStringList(ApiConstants.favoritesKey, favoritesJson);
  }

  // Search History
  Future<void> addToSearchHistory(Location location) async {
    final history = await getSearchHistory();
    // Remove if already exists
    history.removeWhere((loc) => loc.id == location.id);
    // Add to beginning
    history.insert(0, location);
    // Keep only last 10
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }
    await _saveSearchHistory(history);
  }

  Future<List<Location>> getSearchHistory() async {
    final historyJson =
        _prefs.getStringList(ApiConstants.searchHistoryKey) ?? [];
    return historyJson
        .map((json) => Location.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> clearSearchHistory() async {
    await _prefs.remove(ApiConstants.searchHistoryKey);
  }

  Future<void> _saveSearchHistory(List<Location> history) async {
    final historyJson = history.map((loc) => jsonEncode(loc.toJson())).toList();
    await _prefs.setStringList(ApiConstants.searchHistoryKey, historyJson);
  }

  // Last Selected Location
  Future<void> saveLastSelectedLocation(Location location) async {
    await _prefs.setString(
      ApiConstants.lastSelectedLocationKey,
      jsonEncode(location.toJson()),
    );
  }

  Future<Location?> getLastSelectedLocation() async {
    final locationJson =
        _prefs.getString(ApiConstants.lastSelectedLocationKey);
    if (locationJson != null) {
      return Location.fromJson(jsonDecode(locationJson));
    }
    return null;
  }

  Future<void> clearLastSelectedLocation() async {
    await _prefs.remove(ApiConstants.lastSelectedLocationKey);
  }
}
