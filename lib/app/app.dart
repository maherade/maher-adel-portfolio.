import 'package:flutter/material.dart';
import 'package:unping_task/app/theme/app_theme.dart';
import 'package:unping_task/core/providers/theme_provider.dart';
import 'package:unping_task/features/home/home_page.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      mode: _themeMode,
      toggle: _toggleTheme,
      child: MaterialApp(
        title: 'Maher Adel — Flutter Developer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: const HomePage(),
      ),
    );
  }
}
