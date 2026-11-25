import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/location_view_model.dart';
import '../../view_models/weather_view_model.dart';
import '../../models/location.dart';
import '../widgets/location_list_item.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Map<int, bool> _favoritesCache = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFavoriteStatus(
      LocationViewModel viewModel, Location location) async {
    final isFav = await viewModel.isFavorite(location);
    if (mounted) {
      setState(() {
        _favoritesCache[location.id] = isFav;
      });
    }
  }

  void _selectLocation(BuildContext context, Location location) {
    final weatherViewModel = context.read<WeatherViewModel>();
    weatherViewModel.loadWeather(location);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Search Location'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a city...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<LocationViewModel>().clearSearch();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  context.read<LocationViewModel>().searchLocations(value);
                  setState(() {});
                },
              ),
            ),
          ),

          // Content
          Expanded(
            child: Consumer<LocationViewModel>(
              builder: (context, viewModel, child) {
                // Show search results if searching or has results
                if (viewModel.state == LocationSearchState.searching) {
                  return _buildLoadingState();
                } else if (viewModel.state == LocationSearchState.loaded) {
                  return _buildSearchResults(context, viewModel);
                } else if (viewModel.state == LocationSearchState.empty) {
                  return _buildEmptySearchState();
                } else if (viewModel.state == LocationSearchState.error) {
                  return _buildErrorState(viewModel);
                }

                // Show favorites and history when not searching
                return _buildDefaultContent(context, viewModel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSearchResults(
      BuildContext context, LocationViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: viewModel.searchResults.length,
      itemBuilder: (context, index) {
        final location = viewModel.searchResults[index];

        // Load favorite status if not cached
        if (!_favoritesCache.containsKey(location.id)) {
          _loadFavoriteStatus(viewModel, location);
        }

        return LocationListItem(
          location: location,
          isFavorite: _favoritesCache[location.id] ?? false,
          onTap: () => _selectLocation(context, location),
          onFavoriteToggle: () async {
            await viewModel.toggleFavorite(location);
            await _loadFavoriteStatus(viewModel, location);
          },
        );
      },
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No locations found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with a different name',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(LocationViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Searching',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.errorMessage ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultContent(
      BuildContext context, LocationViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Favorites Section
          if (viewModel.favorites.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.favorites.length,
              itemBuilder: (context, index) {
                final location = viewModel.favorites[index];
                return LocationListItem(
                  location: location,
                  isFavorite: true,
                  onTap: () => _selectLocation(context, location),
                  onFavoriteToggle: () async {
                    await viewModel.toggleFavorite(location);
                  },
                );
              },
            ),
            const SizedBox(height: 24),
          ],

          // Search History Section
          if (viewModel.searchHistory.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.history,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Recent Searches',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A),
                          ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    viewModel.clearSearchHistory();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.searchHistory.length,
              itemBuilder: (context, index) {
                final location = viewModel.searchHistory[index];

                // Load favorite status if not cached
                if (!_favoritesCache.containsKey(location.id)) {
                  _loadFavoriteStatus(viewModel, location);
                }

                return LocationListItem(
                  location: location,
                  isFavorite: _favoritesCache[location.id] ?? false,
                  onTap: () => _selectLocation(context, location),
                  onFavoriteToggle: () async {
                    await viewModel.toggleFavorite(location);
                    await _loadFavoriteStatus(viewModel, location);
                  },
                );
              },
            ),
          ],

          // Empty State
          if (viewModel.favorites.isEmpty &&
              viewModel.searchHistory.isEmpty) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_searching,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No favorites or recent searches',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A1A),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Search for a city to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
