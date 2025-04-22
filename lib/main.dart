import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:offline_games_hub/core/navigation/app_router.dart';
import 'package:offline_games_hub/core/theme/app_theme.dart';
import 'package:offline_games_hub/core/services/storage_service.dart';
import 'package:offline_games_hub/providers/theme_provider.dart';
import 'package:offline_games_hub/features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  final storageService = StorageService();
  await storageService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider.value(value: storageService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'OffPlay',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: AppRouter.generateRoute,
          home: const HomePage(),
        );
      },
    );
  }
}
