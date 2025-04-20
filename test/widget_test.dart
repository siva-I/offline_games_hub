// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:offline_games_hub/main.dart';
import 'package:offline_games_hub/providers/theme_provider.dart';

void main() {
  testWidgets('App renders correctly and theme toggle works', (WidgetTester tester) async {
    // Set up SharedPreferences
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that the welcome text is displayed
    expect(find.text('Welcome to Offline Games Hub!'), findsOneWidget);

    // Verify that both buttons are present
    expect(find.text('Start Playing'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Test theme toggle
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
}
