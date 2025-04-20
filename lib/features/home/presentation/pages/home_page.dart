import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:offline_games_hub/providers/theme_provider.dart';
import 'package:offline_games_hub/core/widgets/app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Games Hub'),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Offline Games Hub!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Start Playing',
              onPressed: () {
                // TODO: Navigate to games list
              },
              icon: Icons.play_arrow,
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Settings',
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              isOutlined: true,
              icon: Icons.settings,
            ),
          ],
        ),
      ),
    );
  }
} 