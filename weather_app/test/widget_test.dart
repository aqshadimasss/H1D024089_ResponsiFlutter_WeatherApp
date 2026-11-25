// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Weather app smoke test', (WidgetTester tester) async {
    // Initialize mock services
    SharedPreferences.setMockInitialValues({});
    final localStorageService = await LocalStorageService.create();
    final apiService = ApiService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      localStorageService: localStorageService,
      apiService: apiService,
    ));

    // Verify that app shows initial state
    expect(find.text('Weather App'), findsOneWidget);
    expect(find.text('No Location Selected'), findsOneWidget);
  });
}
