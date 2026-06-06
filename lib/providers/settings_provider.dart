// lib/providers/settings_provider.dart
import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';

class SettingsProvider extends ChangeNotifier {
  final _prefs = SharedPrefsService();

  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('zh', 'CN');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  Future<void> loadSettings() async {
    await _prefs.init();
    _themeMode = _prefs.getThemeMode();
    _locale = _prefs.getLocale();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setThemeMode(mode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _prefs.setLocale(locale);
    notifyListeners();
  }
}
