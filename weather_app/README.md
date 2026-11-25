<img width="543" height="863" alt="image" src="https://github.com/user-attachments/assets/851b8d8e-e435-4f37-9c9c-f7e6dc7a5554" /># Weather App - Responsi Flutter

Aplikasi cuaca berbasis Flutter yang menampilkan informasi cuaca terkini dan perkiraan 7 hari ke depan menggunakan Open-Meteo API.

## Fitur Aplikasi

- Menampilkan informasi cuaca terkini (suhu, kelembapan, kecepatan angin, dll)
- Perkiraan cuaca 7 hari ke depan
- Pencarian lokasi berdasarkan nama kota
- Menyimpan lokasi favorit
- Riwayat pencarian
- Responsif dan mudah digunakan
- Material Design dengan theme konsisten

## Arsitektur

Aplikasi ini dibangun menggunakan pola arsitektur **MVVM (Model-View-ViewModel)** dengan struktur folder sebagai berikut:

```
lib/
├── models/              # Data models (Location, Weather)
├── view_models/         # Business logic & state management
├── views/
│   ├── screens/        # Layar aplikasi (Weather, Search)
│   └── widgets/        # Reusable widgets
├── services/           # API & Local storage services
└── utils/              # Helper functions & constants
```

### Penjelasan MVVM Implementation

**Model**
- `Location` - Model untuk data lokasi dari Geocoding API
- `Weather`, `CurrentWeather`, `DailyWeather` - Model untuk data cuaca dari Weather API
- Menggunakan `json_serializable` untuk serialisasi JSON otomatis

**View**
- `WeatherScreen` - Layar utama yang menampilkan cuaca
- `SearchLocationScreen` - Layar pencarian dan pemilihan lokasi
- Widgets reusable: `WeatherInfoCard`, `DailyForecastCard`, `LocationListItem`

**ViewModel**
- `WeatherViewModel` - Mengelola state dan business logic untuk data cuaca
- `LocationViewModel` - Mengelola state untuk pencarian lokasi, favorites, dan history
- Menggunakan `Provider` untuk state management dan `ChangeNotifier` untuk notifikasi perubahan state

## Teknologi & Dependencies

### Core Dependencies
- **Flutter SDK**: ^3.13.5
- **Dart**: ^3.13.5

### State Management
- **provider**: ^6.1.1 - State management solution

### Networking
- **http**: ^1.1.2 - HTTP client untuk API requests

### Local Storage
- **shared_preferences**: ^2.2.2 - Menyimpan favorites dan history

### JSON Serialization
- **json_annotation**: ^4.8.1
- **json_serializable**: ^6.7.1
- **build_runner**: ^2.4.7

### UI Enhancement
- **weather_icons**: ^3.0.0 - Icon cuaca
- **intl**: ^0.19.0 - Format tanggal dan internasionalization

## API Integration

### Open-Meteo API

**Geocoding API**
- Endpoint: `https://geocoding-api.open-meteo.com/v1/search`
- Fungsi: Mencari lokasi berdasarkan nama kota
- Parameter: `name`, `count`, `language`, `format`

**Weather Forecast API**
- Endpoint: `https://api.open-meteo.com/v1/forecast`
- Fungsi: Mendapatkan data cuaca terkini dan forecast
- Parameter yang digunakan:
  - `latitude` & `longitude` - Koordinat lokasi
  - `current` - Data cuaca terkini
    - `temperature_2m` - Suhu saat ini
    - `relative_humidity_2m` - Kelembapan
    - `apparent_temperature` - Suhu yang dirasakan
    - `precipitation` - Curah hujan
    - `weather_code` - Kode kondisi cuaca
    - `wind_speed_10m` - Kecepatan angin
  - `daily` - Data perkiraan harian
    - `temperature_2m_max` - Suhu maksimum
    - `temperature_2m_min` - Suhu minimum
    - `precipitation_probability_max` - Peluang hujan
    - `weather_code` - Kode kondisi cuaca
  - `timezone=auto` - Zona waktu otomatis
  - `forecast_days=7` - Forecast 7 hari

## Implementasi Requirements

### Bahasa
- Aplikasi dikembangkan menggunakan Flutter dengan Dart
- Menggunakan StatefulWidget (`SearchLocationScreen`) dan StatelessWidget (`WeatherScreen`, widgets lainnya)

### UI (User Interface)
- Menggunakan Flutter Widgets (Card, Container, ListView, GridView, dll)
- Material Design sebagai standar desain
- Theme diimplementasikan dengan `ThemeData` untuk konsistensi
- Typography menggunakan Material Design 3 text styles
- Responsive layout dengan SingleChildScrollView dan GridView

### List & Data
- Local Storage menggunakan SharedPreferences
- Menyimpan:
  - Daftar lokasi favorit
  - Riwayat pencarian (max 10)
  - Lokasi terakhir dipilih
- Data persisten dan dimuat kembali saat aplikasi dibuka

### State & Recomposition
- State management menggunakan Provider dengan ChangeNotifier
- Pencarian lokasi real-time dengan TextField onChanged
- UI update otomatis saat state berubah
- Enum state untuk loading, loaded, error, empty

### Networking
- Menggunakan REST API dari Open-Meteo
- HTTP Request dengan method GET menggunakan package `http`
- JSON response di-parse menjadi Dart models
- Error handling untuk kondisi loading, empty, dan error
- Loading indicator saat fetching data

### Architecture
- MVVM (Model-View-ViewModel) pattern
- Separation of concerns:
  - Models: Data classes
  - Views: UI components
  - ViewModels: Business logic & state
  - Services: API & Storage layer

### Minimum Screens

**1. Home / Weather Screen**
-  Nama kota yang sedang dipilih
-  Kondisi cuaca terkini dengan icon dan deskripsi
-  Suhu saat ini (temperature_2m)
-  Informasi tambahan:
  - Kelembapan udara (relative_humidity_2m)
  - Kecepatan angin (wind_speed_10m)
  - Curah hujan (precipitation)
  - Suhu yang dirasakan (apparent_temperature)
-  Perkiraan cuaca 7 hari ke depan
-  Pull to refresh functionality

**2. Search / Location Screen**
-  Input pencarian kota
-  Daftar hasil pencarian dengan detail lokasi
-  Pemilihan lokasi untuk melihat cuaca
-  Fitur menyimpan lokasi sebagai favorit
-  Tampilan daftar favorit
-  Riwayat pencarian dengan opsi clear

## Screenshots

### Home / Weather Screen
<img width="538" height="862" alt="image" src="https://github.com/user-attachments/assets/74c1cbe7-0768-42c9-ab14-1805cff2fa25" />

Tampilan awal aplikasi ketika belum ada lokasi yang dipilih. Menampilkan tombol untuk memulai pencarian lokasi.

**Weather Display - Current Weather**
<img width="532" height="871" alt="image" src="https://github.com/user-attachments/assets/94b6cc83-f038-4102-b4ea-50c284f8b25e" />

Menampilkan:
- Nama lokasi lengkap (kota, provinsi, negara)
- Tanggal saat ini
- Icon cuaca sesuai kondisi
- Suhu utama (°C)
- Deskripsi kondisi cuaca
- "Feels like" temperature

**Weather Display - Details & Forecast**
<img width="526" height="854" alt="image" src="https://github.com/user-attachments/assets/2191949b-cbb1-40de-89ca-c26c22d4fdd5" />

Menampilkan:
- Weather details dalam grid (Humidity, Wind Speed, Precipitation, Feels Like)
- 7-day forecast dengan:
  - Hari dan tanggal
  - Icon cuaca
  - Peluang hujan
  - Suhu maksimum dan minimum

**Loading State**
<img width="530" height="866" alt="image" src="https://github.com/user-attachments/assets/8d7e9b3d-a249-4d34-b946-7f939e607cf9" />

### Search / Location Screen

**Search with No Query**
<img width="551" height="861" alt="image" src="https://github.com/user-attachments/assets/4b09d765-bce1-467a-96fe-92b531b1a7fd" />

Tampilan awal screen pencarian menampilkan:
- Daftar lokasi favorit (jika ada)
- Riwayat pencarian (jika ada)
- Empty state jika tidak ada data

**Search Results**
<img width="540" height="868" alt="image" src="https://github.com/user-attachments/assets/247d4698-4a08-411f-8ce5-a1461c1582ba" />

Hasil pencarian real-time menampilkan:
- Daftar lokasi yang ditemukan
- Nama kota, provinsi/state, dan negara
- Tombol favorite untuk setiap lokasi
- Icon chevron untuk navigasi

**Favorites Section**
<img width="543" height="863" alt="image" src="https://github.com/user-attachments/assets/796ece9c-d48f-4257-b2b1-6fcb63a62682" />

Daftar lokasi yang disimpan sebagai favorit dengan:
- Icon favorite merah
- Tombol untuk remove dari favorites
- Tap untuk langsung melihat cuaca

**Search History**
<img width="543" height="874" alt="image" src="https://github.com/user-attachments/assets/80b0fb76-bf3a-49ba-a37a-1bab7dcde2d4" />

Riwayat 10 pencarian terakhir dengan:
- Icon history
- Tombol "Clear" untuk hapus semua history
- Status favorite untuk setiap lokasi

**Search Loading**
<img width="531" height="873" alt="image" src="https://github.com/user-attachments/assets/b082667c-ff51-4d8d-bc39-f718d6626d79" />

![Search Loading](screenshots/search_loading.png)

Loading indicator saat melakukan pencarian ke API.

**No Results Found**
<img width="531" height="868" alt="image" src="https://github.com/user-attachments/assets/89f627f9-b955-41ac-aad4-ff017b719c55" />

![No Results](screenshots/no_results.png)

Tampilan ketika pencarian tidak menemukan hasil.

## Cara Menjalankan

### Prerequisites
- Flutter SDK (3.13.5 atau lebih baru)
- Dart SDK (3.13.5 atau lebih baru)
- Android Studio / VS Code dengan Flutter extension
- Emulator Android / iOS atau device fisik

### Langkah-langkah

1. Clone repository
```bash
git clone <repository-url>
cd weather_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate JSON serialization code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run aplikasi
```bash
flutter run
```

## Struktur Kode

### Services Layer

**ApiService** (`services/api_service.dart`)
- `searchLocations(String query)` - Mencari lokasi berdasarkan nama
- `getWeather(double lat, double lon)` - Mendapatkan data cuaca

**LocalStorageService** (`services/local_storage_service.dart`)
- `addFavorite(Location)` - Menambah favorit
- `removeFavorite(Location)` - Menghapus favorit
- `getFavorites()` - Mendapatkan daftar favorit
- `addToSearchHistory(Location)` - Menambah ke history
- `getSearchHistory()` - Mendapatkan history
- `saveLastSelectedLocation(Location)` - Simpan lokasi terakhir

### ViewModels

**WeatherViewModel** (`view_models/weather_view_model.dart`)
```dart
enum WeatherState { initial, loading, loaded, error, empty }

class WeatherViewModel extends ChangeNotifier {
  - loadWeather(Location)
  - refreshWeather()
  - clearError()
}
```

**LocationViewModel** (`view_models/location_view_model.dart`)
```dart
enum LocationSearchState { initial, searching, loaded, error, empty }

class LocationViewModel extends ChangeNotifier {
  - searchLocations(String query)
  - toggleFavorite(Location)
  - isFavorite(Location)
  - clearSearch()
  - clearSearchHistory()
}
```

## Theme & Styling

Aplikasi menggunakan Material Design 3 dengan:
- Color scheme: Blue seed color
- Typography: Material Design 3 text styles
- Rounded corners (12px border radius)
- Elevation untuk depth
- Gradient backgrounds untuk current weather card
- Conditional coloring berdasarkan weather code

## State Management Flow

```
User Action (View)
    ↓
ViewModel Method Called
    ↓
Service Called (API/Storage)
    ↓
State Updated
    ↓
notifyListeners()
    ↓
View Rebuilds (Consumer)
    ↓
UI Updated
```

## Data Flow

1. **Search Location**
   - User input → LocationViewModel.searchLocations()
   - ApiService.searchLocations() → Open-Meteo Geocoding API
   - Results → Update state → View updates

2. **Load Weather**
   - Select location → WeatherViewModel.loadWeather()
   - ApiService.getWeather() → Open-Meteo Weather API
   - Save to history & last selected
   - Results → Update state → View updates

3. **Favorites**
   - Toggle favorite → LocationViewModel.toggleFavorite()
   - LocalStorageService → SharedPreferences
   - Update list → notifyListeners() → View updates

## Testing

Run tests:
```bash
flutter test
```

Run app analysis:
```bash
flutter analyze
```
