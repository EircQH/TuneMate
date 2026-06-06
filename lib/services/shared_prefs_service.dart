import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLocale = 'locale';
  static const String _keyFavorites = 'favorites';

  SharedPreferences? _prefs;

  SharedPreferences get _requirePrefs {
    assert(_prefs != null, 'SharedPrefsService.init() must be called first');
    return _prefs!;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 主题
  ThemeMode getThemeMode() {
    final value = _requirePrefs.getString(_keyThemeMode);
    switch (value) {
      case 'dark': return ThemeMode.dark;
      case 'light': return ThemeMode.light;
      default: return ThemeMode.dark; // 默认暗黑
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _requirePrefs.setString(_keyThemeMode, mode == ThemeMode.dark ? 'dark' : 'light');
  }

  // 语言
  Locale getLocale() {
    final value = _requirePrefs.getString(_keyLocale);
    if (value == 'en') return const Locale('en', 'US');
    return const Locale('zh', 'CN');
  }

  Future<void> setLocale(Locale locale) async {
    await _requirePrefs.setString(_keyLocale, locale.languageCode);
  }

  // 收藏的特调ID列表
  List<String> getFavoriteIds() {
    return _requirePrefs.getStringList(_keyFavorites) ?? [];
  }

  Future<void> setFavoriteIds(List<String> ids) async {
    await _requirePrefs.setStringList(_keyFavorites, ids);
  }
}
